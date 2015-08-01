module API
	class AuthController < ApplicationController
		def get_token
			authenticate_or_request_with_http_basic do |uid, password|
				user = User.find_by_uid(uid)
				if user.valid_password?(password)
					render json: user, status: 200
				end
			end
		end
	end
end