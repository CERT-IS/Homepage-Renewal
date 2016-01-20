class Project < ActiveRecord::Base
	has_many :user_project_mappeds
	has_many :users, through: :user_project_mappeds
end
