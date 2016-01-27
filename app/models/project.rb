class Project < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	
	has_many :user_project_mappeds, dependent: :destroy
	has_many :users, through: :user_project_mappeds

	validates :title, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true

    def master
    	users.where(
			"user_project_mappeds.master = ?",
			true
		).first
	end
end
