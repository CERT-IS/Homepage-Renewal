class CalendarController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@date = Date.today
		if params.present?
			@date   = Date.parse("#{params[:year]}-#{params[:month]}-01")
			@events = Event.get_events(@date)
		else
			@events = Event.get_events(@date)
		end

		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
	end

	def create
		start_day_var = DateTime.parse(params[:event][:start_day])
		Event.create(
			title: 			params[:event][:title],
			start_day: 		start_day_var,
			start_time: 	params[:event][:start_time],
			end_day: 		DateTime.parse(params[:event][:end_day]),
			end_time: 		params[:event][:end_time],
			location: 		params[:event][:location],
			description: 	params[:event][:description],
			start_allday: 	params[:event].has_key?(:start_allday) ? (params[:event][:start_allday].eql?("true") ? true : false) : false,
			end_allday: 	params[:event].has_key?(:end_allday) ? (params[:event][:end_allday].eql?("true") ? true : false) : false
		)
		redirect_to calendar_index_path(year: start_day_var.year, month: start_day_var.month)
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
