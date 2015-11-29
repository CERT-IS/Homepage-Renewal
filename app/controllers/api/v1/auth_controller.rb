module API
	module V1
		class AuthController < ApplicationController
			before_action :check_format, except: :get_token

			def get_token
				authenticate_or_request_with_http_basic do |uid, password|
					user = User.find_by_uid(uid)
					
					if user.present? and user.valid_password?(password) and user.member?
						render json: user, status: 200
					else
						render json: 'Bad credentials', status: 401
					end		
				end
			end

			protected

			def authenticate!
				logger.debug "DEBUG::API::V1 authenticate! function called."
			  	authenticate_token || render_unauthorized
			end

			def authenticate_token
				logger.debug "DEBUG::API::V1 authenticate_token function called."
				token_log    = ""
				return_value = ""
				authenticate_with_http_token do |token, options|
					token_log    = token 
					user         = User.find_by(authentication_token: token)
					return_value = (user.present? and user.member?)
				end
				logger.debug "DEBUG::API::V1 token=#{token_log}"
				logger.debug "DEBUG::API::V1 return=#{return_value}"
				return return_value
			end

			def render_unauthorized
		      		self.headers['WWW-Authenticate'] = 'Token realm="Application"'
		      		render json: 'Bad credentials', status: 401
		    	end

			def check_format
				render :nothing => true, :status => 406 unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
			end

		end
	end
end
