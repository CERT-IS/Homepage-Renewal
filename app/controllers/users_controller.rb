class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :sfinger, :sfinger_register]

	def index
	end
	
	def show
		@user   = User.where(uid: params[:id]).first

		redirect_to root_path unless @user.present?

		@boards = @user.boards.where(board_type: BoardType.where(name: "frees").first)

		# pagination
		@page   	= params[:page].present? ? params[:page].to_i : 1
		@page_max	= (@boards.count-1) / 4 + 1 if @boards.present?
		@boards 	= @boards.paginate(:page => params[:page], :per_page => 4)

		respond_to do |format|
			format.html
			format.js
		end
	end

	def update_avatar
		@user = User.where(uid: params[:id]).first

		if @user.present?
			@user.avatar = params[:user][:avatar]
			@user.save
		end

		redirect_to :back
	end

	def like
		@board = Board.find_by_id(params[:board_id])
		@call  = nil
		if params[:board_type].present?
			@call = "timeline"
		end
		current_user.like!(@board)

		respond_to do |format|
			format.js
		end
	end

	def unlike
		@board = Board.find_by_id(params[:board_id])
		if params[:board_type].present?
			@call = "timeline"
		end
		current_user.unlike!(@board)

		respond_to do |format|
			format.js
		end
	end

	def sfinger
	end

	def sfinger_register
		now = DateTime.now

		@user = User.where(uid: params[:id]).first

		unless @user.present?
			puts "Users#sfinger_register - create new user"
			pw = Devise.friendly_token.first(20)
			@user = User.create!(
				uid: params[:id],
				realname: params[:id],
				email: params[:email],
				phone: params[:phone],
				created_at: now,
				updated_at: now,
				password: pw,
				password_confirmation: pw,
				provider: "s-finger"
			)
		end

		puts @user.id

		sign_in @user
		respond_to do |format|
			format.js { render js: "document.location = '#{root_path}'" }
			format.html { redirect_to root_path }
		end
	end
end
