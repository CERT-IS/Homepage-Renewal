class Event < ActiveRecord::Base
	validates :title, presence: true
	validates :start_day, presence: true
	validates :end_day, presence: true

	def self.get_events
		where.not(
			'(end_day <= ? AND start_day >= ?)',
			Date.today.prev_month,
			Date.today.next_month
		)
	end
end
