module API
	module V1
		class BoardsController < AuthController
			before_action :authenticate_api
			before_action :get_board, only: [:show, :edit, :update, :destroy]
			before_action :check_auth, only: [:edit, :update, :destroy]

			def index
			end

			def show
				# 부정접근 처리
				unless @board.present?
					redirect_to root_path
					return
				end

				@comments = @board.comments.where(comment_id: nil)
			end

			def new
			end

			def create
			end

			def edit
				@board_type = @board.board_type
			end

			def update
			end

			def destroy
				redirect_to "/#{@board.board_type.name}"
				@board.destroy
			end

			private

			def get_board
				@board = Board.where(id: params[:id]).first
			end

			def check_auth
				authorize_action_for @board
			end
		end
	end
end
