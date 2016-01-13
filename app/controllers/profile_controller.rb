class ProfileController < ApplicationController
	before_action :get_user, only: [:index, :update]

	def index
		redirect_to root_path unless @user.present?
	end

	def update
		@user.update(
			nickname:  params[:profile][:nickname],
			introduce: params[:profile][:introduce]
		)

		redirect_to user_profile_index_path(@user.uid)
	end

	private

	def get_user
		@user = User.where(uid: params[:user_id]).first
	end
end
