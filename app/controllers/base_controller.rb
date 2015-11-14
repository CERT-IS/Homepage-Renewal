class BaseController < ApplicationController
	before_action :authenticate_user!, only: :test

	def index
	end

	def privacy
	end

	def terms
	end

	def test
	end
end
