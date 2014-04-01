class ResultController < ApplicationController
  def index
   @events = Event.where('unique_id' => params[:event_id]).first
  end
  def update
    @event = Event.where('unique_id' => params[:event_id]).first
    @votes = @event.votes
    UserMailer.admin_email(@votes, @event).deliver
    @votes.each do |vote|
      UserMailer.confirm_email(vote, @event).deliver
    end
    format.json { render :json=>{:status=>'Done',:events=>{:id=>@event.id}}}
  end
end
        
