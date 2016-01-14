module API
	module V1
		class BoardsController < AuthController
			before_action :authenticate_api

			def index
			end

			def show
				@board = Board.where(id: params[:id]).first

				# 부정접근 처리
				unless @board.present?
					redirect_to root_path
					return
				end

				@comments = @board.comments.where(comment_id: nil)
			end
		end
	end
end
