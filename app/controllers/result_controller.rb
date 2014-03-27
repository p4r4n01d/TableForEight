class ResultController < ApplicationController
  def index
   @events = Event.find_by_id(params[:event_id])
  end
  def update
    @event = Event.find_by_id(params[:event_id])
    @votes = @event.votes
    UserMailer.admin_email(@votes, @event).deliver
    @votes.each do |vote|
      UserMailer.confirm_email(@vote.email, @event).deliver
    end
  end
end
        
