class VotesController < ApplicationController

  before_filter :get_event

  def get_event
    @event = Event.find(params[:event_id])
  end

  # GET /events/:event_id/votes/:id
  def index
    @votes = @event.votes.find(params[:id])
    render json: @votes
  end

  # GET /events/:event_id/votes
  def show
    render json: @event.votes
  end

  # POST /events/:event_id/votes
  def create
    @vote = @event.Vote.new(params[:vote])
    respond_to do |format|
      if @vote.save
        format.json { head :no_content, status: :created }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /votes/:vote_id
  def destroy
    @vote = Vote.find(params[:id])
    respond_to do |format|
      if @vote.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
  end
end
