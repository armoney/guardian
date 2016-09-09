class EventsController < ApplicationController

	def index
		@events = current_user.events.limit(8)
		@user = current_user
	end

	def new
		# render 'in-progress'
	end

	def create
		@event = Event.new(user_id: current_user.id, drone_id: 1, event_status: "not connected")

		if @event.save
			@user = current_user
			message = "This is #{@user.first_name} #{@user.last_name}. Thanks for watching that I get home safely! Link to watch: http://guardian-drone.herokuapp.com/events/#{@event.id}/stream"

	 		to = @user.friends.first
	 		client = Twilio::REST::Client.new(
	    	ENV["TWILIO_ACCOUNT_SID"],
	    	ENV["TWILIO_AUTH_TOKEN"]
	  	)
	  	if client.messages.create(

	    		to: @user.friends.first.phone_number,
	    		from: "+16502156875",
	     		body: message
	    	)
	    	flash[:notice] = "Message has been sent!"
	  	else
	    	flash[:notice] = "Error: Message did not send"
	  	end

			if request.xhr?
				@event.update(place_id: params["place_id"])
				render status: 200, :json => {event_id: "#{@event.id}", drone_id: "#{@event.drone.id}"}

			end
		else
			@error_messages = @event.errors.full_messages
			p @error_messages
			root_path
		end
	end

	def edit
		edit_event_path
	end

	def show
		@event = Event.find(params[:id])
		@user = User.find(@event.user.id)

		#friend variable will need to be updated
		@friend = Friend.find(@user.friends.first.id)
		event_path
	end

	def update
		p params
		@event = Event.find(params[:id])
		@event.update(event_status: params[:event_status])
	end

	def destroy
		# does user need to be able to destroy event from the events index?
	end

	def stream
		@event = Event.find(params[:event_id])
		event_stream_path
	end

	def status
		@event = Event.find(params[:event_id])
		render status: 200, :json => { event_status: @event.event_status }
	end

end
