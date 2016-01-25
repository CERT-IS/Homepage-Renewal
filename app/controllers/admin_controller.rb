class AdminController < ApplicationController
	before_action :authenticate_user!
	
	def membership
		@users = User.all
	end

	def membership_update
		members = User.where(id: params[:membership][:member])

		if params[:commit].eql?("변경")
			members.each do |member|
				member.roles.delete_all
				member.add_role params[:membership][:grade].to_sym
			end
		end

		if params[:commit].eql?("강제 탈퇴")
			members.each do |member|
				member.destroy
			end
		end

		redirect_to admin_membership_path
	end

	def grades
		@type   	= BoardType.where(name: "grades").first
		@boards  	= @type.boards
	end

	def grades_update
		boards = Board.where(id: params[:grades][:member])

		if params[:commit].eql?("변경")
			boards.each do |board|
				board.user.roles.delete_all
				board.user.add_role params[:grades][:grade].to_sym
				board.destroy
			end
		end

		if params[:commit].eql?("강제 탈퇴")
			boards.each do |board|
				board.user.destroy
			end
		end

		redirect_to admin_grades_path
	end
end
