class CalendarController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@events = Event.get_events
	end

	def create
		Event.create(
			title: 			params[:event][:title],
			start_day: 		DateTime.parse(params[:event][:start_day]),
			start_time: 	params[:event][:start_time],
			end_day: 		DateTime.parse(params[:event][:end_day]),
			end_time: 		params[:event][:end_time],
			location: 		params[:event][:location],
			description: 	params[:event][:description],
			start_allday: 	params[:event].has_key?(:start_allday) ? (params[:event][:start_allday].eql?("true") ? true : false) : false,
			end_allday: 	params[:event].has_key?(:end_allday) ? (params[:event][:end_allday].eql?("true") ? true : false) : false
		)
		redirect_to calendar_index_path
	end

	def update
	end

	def destroy
	end
end
