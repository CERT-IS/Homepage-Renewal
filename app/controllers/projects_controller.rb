class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_project, only: [:show]

	def index
	end

	def new
		@project = current_user.projects.new
	end

	def create
		@project = current_user.projects.new(project_params)
		if @project.save
			UserProjectMapped.create(
				user: current_user,
				project: @project,
				master: true
			)
			redirect_to @project
		else
			render 'new'
		end
	end

	def show
		@project_master = 	@project.users.where(
								"user_project_mappeds.master = ?",
								true
							).first
	end

	def edit
	end

	def update
	end

	def destory
	end

	private

	def get_project
		@project = Project.where(id: params[:id]).first
	end

	def project_params
		params.require(:project).permit(
			:title,
			:description,
			:start_date,
			:end_date
		)
	end
end
