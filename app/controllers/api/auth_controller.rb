module API
	class AuthController < ApplicationController
		def get_token
			authenticate_or_request_with_http_basic do |uid, password|
				user = User.find_by_uid(uid)
				head 401 unless user.present?
				
				if user.valid_password?(password)
					render json: user, status: 200
				else
					head :401
				end
			end
		end
	end
end