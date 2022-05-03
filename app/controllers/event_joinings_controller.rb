class EventJoiningsController < ApplicationController
  def new
    @event = current_user.hosted_events.build
  end

  def create
    @event = Event.find(params[:event_id])
    @event_joining = EventJoining.new(attended_event_id: @event.id, joined_user_id: current_user.id)

    respond_to do |format|
      if @event_joining.save
        format.html { redirect_to event_url(@event), notice: "It worked!" }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { redirect_to event_url(@event), notice: 'Ooops! Something went wrong...' }
      end
    end
  end
end
