class CalendarController < ApplicationController
	include ActionView::Helpers::TextHelper
	before_action :authenticate_user!
	before_action :get_event, only: [:show, :edit, :update, :destroy]
	before_action :check_auth, only: [:edit, :update, :destroy]
	
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

		Event.create(
			title: 			params[:event][:title],
			start_day: 		start_day_var,
			start_time: 	params[:event][:start_time],
			end_day: 		DateTime.parse(params[:event][:end_day]),
			end_time: 		params[:event][:end_time],
			location: 		params[:event][:location],
			description: 	 params[:event][:description],
			start_allday: 	params[:event].has_key?(:start_allday) ? (params[:event][:start_allday].eql?("true") ? true : false) : false,
			end_allday: 	params[:event].has_key?(:end_allday) ? (params[:event][:end_allday].eql?("true") ? true : false) : false
		)
		redirect_to calendar_index_path(year: start_day_var.year, month: start_day_var.month)
	end

	def edit
	end

	def update
		start_day_var = DateTime.parse(params[:event][:start_day])

		@event.update(
			title: 			params[:event][:title],
			start_day: 		start_day_var,
			start_time: 	params[:event][:start_time],
			end_day: 		DateTime.parse(params[:event][:end_day]),
			end_time: 		params[:event][:end_time],
			location: 		params[:event][:location],
			description: 	 params[:event][:description],
			start_allday: 	params[:event].has_key?(:start_allday) ? (params[:event][:start_allday].eql?("true") ? true : false) : false,
			end_allday: 	params[:event].has_key?(:end_allday) ? (params[:event][:end_allday].eql?("true") ? true : false) : false
		)
		redirect_to calendar_index_path(year: start_day_var.year, month: start_day_var.month)
	end

	def destroy
		@event_id = @event.id
		@event.destroy
	end

	private

	def get_event
		@event = Event.where(id: params[:id]).first
	end

	def check_auth
		authorize_action_for @event
	end
end
