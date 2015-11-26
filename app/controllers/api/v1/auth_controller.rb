module API
	module V1
		class AuthController < ApplicationController
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
				authenticate_with_http_token do |token, options|
					user = User.find_by(authentication_token: token)

					unless user.present? or user.member?
						respond_to do |format|
				  			format.json { render json: 'Bad credentials', status: 401 }
				  		end
				  		return
					end
				end
			end

		end
	end
end