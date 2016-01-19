class CalendarController < ApplicationController
	include ActionView::Helpers::TextHelper
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
		@event = Event.where(id: params[:id]).first
		@event_day = @event.start_day.strftime("%y.%m.%d ")
		if @event.start_allday
			@event_day += "종일"
		else
			@event_day += @event.start_time
		end

		unless (@event.start_day == @event.end_day)
			@event_day += " - #{@event.end_day.strftime("%y.%m.%d ")}"
			if @event.end_allday
				@event_day += "종일"
			else
				@event_day += @event.end_time
			end
		else
			unless @event.start_allday
				@event_day += " - #{@event.end_time}"
			end
		end
	end

	def create
		start_day_var = DateTime.parse(params[:event][:start_day])
		description   = params[:event][:description].gsub(/(?:\n\r?|\r\n?)/, "<br>")
		description   = auto_link(description, :html => { :target => '_blank' }) do |text|
							truncate(text, :length => 50)
						end

		Event.create(
			title: 			params[:event][:title],
			start_day: 		start_day_var,
			start_time: 	params[:event][:start_time],
			end_day: 		DateTime.parse(params[:event][:end_day]),
			end_time: 		params[:event][:end_time],
			location: 		params[:event][:location],
			description: 	description,
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
