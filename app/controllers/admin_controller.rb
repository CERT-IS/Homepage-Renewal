class AdminController < ApplicationController
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
			members.delete_all
		end

		redirect_to admin_membership_path
	end
end
