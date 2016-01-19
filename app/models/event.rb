class Event < ActiveRecord::Base
	resourcify
  	include Authority::Abilities
  	self.authorizer_name = 'EventAuthorizer'

	validates :title, presence: true
	validates :start_day, presence: true
	validates :end_day, presence: true

	def self.get_events(date)
		where.not(
			'(end_day < ? OR start_day > ?)',
			date.prev_month,
			date.next_month
		)
	end
end
