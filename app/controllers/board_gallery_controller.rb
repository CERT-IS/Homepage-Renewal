class BoardGalleryController < BoardsController
	def index
		super
		@page   	= params[:page].to_i == 0 ? 1 : params[:page].to_i
		@type   	= BoardType.where(name: "galleries").first
		@boards  	= @type.boards
		@page_max	= (@boards.count-1) / 4 + 1 if @boards.present?
		@boards 	= @boards.paginate(:page => params[:page], :per_page => 4)
	end

	def show
		super
	end

	def new
		super
		@board_type	= BoardType.where(name: "galleries").first
		@board 		= @board_type.boards.new
	end

	def create
		super
		@board.board_type = BoardType.where(name: "galleries").first
		@board.save

		redirect_to galleries_path
	end

	def destroy
		super
	end
end