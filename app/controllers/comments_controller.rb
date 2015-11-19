class CommentsController < ApplicationController
	def create
		board 	 = Board.find_by_id(params[:board_id])

		if params[:comment_id].present?
			origin = Comment.find_by_id(params[:comment_id])
			@comment = origin.replys.create(
				user: current_user,
				board: board,
				contents: params[:comment][:contents]
			)
		else
			@comment = current_user.comments.create(
				board: board,
				contents: params[:comment][:contents]
			)
		end

		respond_to do |format|
			format.js
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
