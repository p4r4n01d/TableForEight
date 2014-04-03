class ResultController < ApplicationController
  before_filter :get_event

  def index
   @events = @event
   @votes = @events.votes
  end

  def update
    @votes = @event.votes
    UserMailer.admin_email(@votes, @event).deliver
    @votes.each do |vote|
      UserMailer.confirm_email(vote, @event).deliver
    end
    render json: @event, status: :ok
  end

  private
    def get_event
      @event = Event.where('unique_id' => params[:event_id]).first
    end
end

