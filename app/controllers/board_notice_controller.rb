class BoardNoticeController < BoardsController
	def index
		super
		@type   = BoardType.where(name: "notice").first
		@boards = @type.boards

		respond_to do |format|
			format.html
			format.json { render json: @boards, except: [:contents, :updated_at, :user_id], include: {user:{only: :uid}}, status: 200 } 
		end
	end

	def show
		super
	end

	def new
		super
		@board_type	= BoardType.where(name: "notice").first
		@board 		= @board_type.boards.new
	end

	def create
		super
		@board.board_type = BoardType.where(name: "notice").first
		@board.save

		redirect_to notices_path
	end

	def destroy
		super
	end
end
