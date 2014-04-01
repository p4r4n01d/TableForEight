class VotingController < ApplicationController
  def index
      @events = Event.where('unique_id' => params[:event_id]).first
      @votes = Vote.where('unique_id' => params[:vote_id]).first
  end
end
