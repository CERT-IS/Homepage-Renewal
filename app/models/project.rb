class Project < ActiveRecord::Base
	has_many :user_project_mappeds
	has_many :users, through: :user_project_mappeds

	validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
end
