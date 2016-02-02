class InquiriesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_inquiry, only: [:show, :destroy]

	def show
	end

	def create
		@inquiry = Inquiry.new(inquiry_params)
		redirect_to root_path if @inquiry.save
	end

	def destroy
		@inquiry.destroy
		redirect_to admin_inquiries_path
	end

	private

	def get_inquiry
		@inquiry = Inquiry.where(id: params[:id]).first
	end

	def inquiry_params
		params.require(:inquiry).permit(
			:name,
			:email,
			:content
		)
	end
end
