module API
	class BoardsController < ApplicationController
		before_action :authenticate_token
		
		def index
			@boards = BoardType.where(name: "notice").first.boards
			render json: @boards, except: [:contents, :updated_at, :user_id], include: {user:{only: :uid}}, status: 200
		end
	end
end