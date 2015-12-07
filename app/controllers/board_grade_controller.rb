class BoardGradeController < BoardsController

	def show
		super
	end

	def new
		super
		@board_type	= BoardType.where(name: "grades").first
		@board = @board_type.boards.where(user_id: current_user.id).first

		if @board.present?
			redirect_to grade_path(@board)
			return 
		else
			@board 		= @board_type.boards.new
		end
	end

	def create
		super
		@board.board_type = BoardType.where(name: "grades").first
		@board.save
		@board.comments.create(
			user: Role.where(name: "admin").first.users.first,
			contents: "등업심사 대기 중입니다. 반려 시 댓글로 반려사유가 등록되오니 확인 부탁드립니다."
		)

		redirect_to grade_path(@board)
	end	

	def destroy
		# don't inherit
		get_board
		check_auth
		@board.destroy
		redirect_to "/admin/grades"
	end

	def edit
		super
	end

	def update
		super
	end

	private

	def get_board
		@board = Board.where(id: params[:id]).first
	end

	def check_auth
		authorize_action_for @board
	end
end
