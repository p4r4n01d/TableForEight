class ResultController < ApplicationController
  def index
   @events = Event.where('unique_id' => params[:event_id]).first
    @votes = @events.votes
  end
  def update
    @event = Event.where('unique_id' => params[:event_id]).first
    @votes = @event.votes
    UserMailer.admin_email(@votes, @event).deliver
    @votes.each do |vote|
      UserMailer.confirm_email(vote, @event).deliver
    end
    format.json { render :json=>{:status=>'Done',:events=>{:id=>@event.unique_id}}}
  end
end
        
