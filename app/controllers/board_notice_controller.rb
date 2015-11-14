class BoardNoticeController < BoardsController
	before_action :authenticate
	
	def index
		super
		@boards = BoardType.where(name: "notice").first.boards
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
