class VotesController < ApplicationController

  before_filter :get_event

  def get_event
    @event = Event.find(params[:event_id])
  end

  # GET /events/:event_id/votes/:organiser_id
  def index
    @votes = @event.votes.find(params[:id])
    render json: @votes
  end

  # POST /votes/:event_id/votes/:organiser_id
  def create
    @vote = Vote.new(params[:vote])
    @vote.save
    render json: @vote
  end

  # DELETE /votes/:event_id
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
  end
end
