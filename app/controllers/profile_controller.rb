class ProfileController < ApplicationController
	def index
		@user = User.where(uid: params[:user_id]).first

		redirect_to root_path unless @user.present?
	end
end
