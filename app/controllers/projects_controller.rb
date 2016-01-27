class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_project, only: [:show, :edit, :update, :destroy]

	def index
		@projects = Project.all
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
		redirect_to root_path unless @project.present?
	end

	def edit
	end

	def update
		@project.update!(project_params)
		redirect_to @project
	end

	def destroy
		@project.destroy
		redirect_to projects_path
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
