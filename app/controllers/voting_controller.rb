class VotingController < ApplicationController
  def index
      @events = Event.find(:all, :conditions => {:hash => params[:event_id]})
      @votes = Vote.find_by_id(params[:vote_id])
  end
end
