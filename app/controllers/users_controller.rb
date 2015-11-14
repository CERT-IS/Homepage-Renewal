class UsersController < ApplicationController
	before_action :authenticate_user!
	
	def show
		@user = User.where(uid: params[:id]).first

		redirect_to root_path unless @user.present?
	end

	def update_avatar
		@user = User.where(uid: params[:id]).first

		if @user.present?
			@user.avatar = params[:user][:avatar]
			@user.save
		end

		redirect_to :back
	end
end
