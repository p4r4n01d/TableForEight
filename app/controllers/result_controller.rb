class ResultController < ApplicationController
  def index
   @events = Event.find_by_id(params[:event_id])
  end
  def update
    @event = Event.find_by_id(params[:event_id])
    @votes = @event.votes
    UserMailer.admin_email(@votes, @event).deliver
    @votes.each do |vote|
      UserMailer.confirm_email(vote, @event).deliver
    end
    format.json { render :json=>{:status=>'created',:events=>{:id=>@event.id}}}
  end
end
        
