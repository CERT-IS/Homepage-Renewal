module API
	module V1
		class BoardsController < AuthController
			before_action :authenticate_token!

			def index
			end
		end
	end
end