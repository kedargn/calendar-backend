class EventsController < BaseController
	before_filter :find_calendar_events, only: [:index, :create]
	before_filter :find_event, only: [:update, :destroy, :show]

	def index
		render status: 200, json: @events
	end

	def show
		render status: 200, json: @event
	end

	def create
		event = @events.create!(event_params)
		render status: 200, json: event
	end

	def update
		update_type = params[:recurring].try(:[],:update_type)
		if @event.non_reccuring_event?
			@event.update_attributes!(event_params)
		elsif update_type == "individual"
			modified_event = find_calendar_events.new(event_params)
			modified_event.recurring_event_id = @event.id
			modified_event.save!
			@event = modified_event
		elsif update_type == "following"
			new_recurring_event = find_calendar_events.new(event_params)
			new_recurring_event.save!
			@event = new_recurring_event
		else
			@event.update_attributes!(event_params)
		end
		render status: 200, json: @event
	end

	def destroy
		byebug
		events = [@event.destroy]
		render status: 200, json: @event + Event.find_by_recurring_event_id(@event.id).try(:destroy)
	end

	private

	def find_event
		@event = Event.find(params[:id])
	end

	def find_calendar_events
		@events = Cal.find(params[:cal_id]).events
	end

	def event_params
		params.require(:event).permit(:name, :start_time, :end_time, :status, :cal_id, :recurrence)
	end
end