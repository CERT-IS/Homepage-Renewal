class Project < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	
	has_many :user_project_mappeds, dependent: :destroy
	has_many :users, through: :user_project_mappeds

	validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 3000 }
    validates :start_date, presence: true, length: { maximum: 255 }
    validates :end_date, presence: true, length: { maximum: 255 }

    def master
    	users.where(
			"user_project_mappeds.master = ?",
			true
		).first
	end

	def members
		users.where(
			"user_project_mappeds.approval = ?",
			true
		)
	end

	def joined?(user)
		users.include?(user)
	end

	def unreceived
		users.where(
			"user_project_mappeds.approval = ?",
			false
		)
	end
end
