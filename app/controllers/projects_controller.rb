class ProjectsController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def new
		@project = current_user.projects.new
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def destory
	end
end
