class ResultController < ApplicationController
  def index
   @events = Event.find_by_id(params[:event_id])
  end
  def update
    @event = Event.find_by_id(params[:event_id])
    @vote = @event.votes.find_by_id(params[:vote_id])
    UserMailer.confirm_email(@vote, @event).deliver
  end
end
        
