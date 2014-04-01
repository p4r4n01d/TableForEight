class VotingController < ApplicationController
  def index
      @events = Event.find_by_id(params[:event_id])
      @votes = Vote.find_by_id(params[:vote_id])
  end
end
