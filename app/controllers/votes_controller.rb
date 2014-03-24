class VotesController < ApplicationController

  before_filter :get_event only :index, :show, :create, :countvotes
  before_filter :get_vote only :destroy, :update

  # GET /events/:event_id/votes/:id
  def index
    @votes = @event.votes.find(params[:id])
    render json: @votes
  end

  # GET /events/:event_id/votes
  def show
    render json: @event.votes
  end

  # GET /events/:event_id/countvotes
  def countvotes
    render json: @event.Vote.count_votes
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
    respond_to do |format|
      if @vote.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
  end


  # PUT /votes/:vote_id
  def update
    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_event
      @event = Event.find(params[:event_id])
    end

    def get_vote
      @vote = Vote.find(params[:id])
    end

    def post_params
      params.require(:email).permit(:link1, :link2, :link3, :link4, :link5, :date1, :date2, :date3, :confirmed)
    end
end
