class BoardReportController < BoardsController
	def index
		super
		@page   	= params[:page].to_i == 0 ? 1 : params[:page].to_i
		@type   	= BoardType.where(name: "reports").first
		@boards  	= @type.boards
		@page_max	= @boards.present? ? (@boards.count-1) / 10 + 1 : 1
		@boards 	= @boards.paginate(:page => params[:page], :per_page => 10)
	end

	def show
		super
	end

	def new
		super
		@board_type	= BoardType.where(name: "reports").first
		@board 		= @board_type.boards.new
		@labels		= Label.all[0..2]
	end

	def create
		super
		@board.board_type = BoardType.where(name: "reports").first
		@board.label      = Label.where(id: params[:board][:label_id]).first
		@board.save
		@board.comments.create(
			user: Role.where(name: "admin").first.users.first,
			contents: "제보에 감사드립니다. 빠른 시일 내에 확인하여 수정하도록 하겠습니다."
		)

		redirect_to report_path(@board)
	end

	def destroy
		super
	end

	def edit
		super
		if current_user.has_role?(:admin)
			@labels	= Label.all
		else
			@labels = Label.all[0..2]
		end
	end

	def update
		super
		@board.label      = Label.where(id: params[:board][:label_id]).first
		@board.isopen	  = params[:board][:isopen].eql?("true")
		@board.save
	end
end
