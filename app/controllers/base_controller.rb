class BaseController < ApplicationController
	before_action :authenticate_user!, only: :test

	def index
	end

	def privacy
	end

	def terms
	end

	def test
		respond_to do |format|
			format.html
			format.json { render json: 'This is test respond', status: 200 }
		end
	end
end
