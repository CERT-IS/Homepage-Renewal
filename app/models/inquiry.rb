class Inquiry < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true, length: { maximum: 255 }
	validates :email, presence: true, length: { maximum: 255 }
	validates :content, presence: true, length: { maximum: 1000 }
end
