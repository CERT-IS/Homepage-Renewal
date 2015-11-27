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
			  	unless authenticate_token
			  		respond_to do |format|
			  			format.json { render json: 'Bad credentails', status: 401 }
			  			format.html { redirect_to new_user_session_path }
			  		end
			  	end
			end

			def authenticate_token!
				authenticate_or_request_with_http_token do |token, options|
					user = User.find_by(authentication_token: token)

					unless user.present? and user.member?
						respond_to do |format|
				  			format.json { render json: 'Bad credentials', status: 401 }
				  		end
				  		return
					end
				end
			end

			private

			def check_format
				render :nothing => true, :status => 406 unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
			end

		end
	end
end