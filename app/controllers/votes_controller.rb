class VotesController < ApplicationController

  before_filter :get_event, :except => [:destroy, :update, :show]
  before_filter :get_vote, :except => [:index, :update, :create, :countvotes]
  before_filter :get_event_vote, :except => [:index, :show, :create, :countvotes, :destroy]
  respond_to :json

  # GET /api/events/:event_id/votes
  def index
    respond_with @event, @event.votes
  end

  # GET /api/votes/:id
  def show
    respond_with @vote
  end

  # POST /api/events/:event_id/votes
  def create
    @vote = @event.votes.create(vote_params)
    if @vote.save
	    flash[:notice] = "Vote was created successfully."
	    UserMailer.admin_welcome_email(@vote, @event).deliver
    end
    respond_with(@vote)
  end

  # DELETE /api/votes/:vote_id
  def destroy
    if @vote.present? && @vote.destroy
      render json: { head :no_content, status: :ok }
    else
      render json: { @vote.errors.full_messages, status: :unprocessable_entity }
    end
  end

  # PUT /api/votes/:vote_id
  def update
    if @vote.present? && @vote.update_attributes(vote_params)
      render json: @vote, status: :ok 
    else
      render json: @vote.errors.full_messages, status: :unprocessable_entity 
    end
  end

  private
    def get_event
      @event = Event.where('unique_id' => params[:event_id]).first
      if !@event
        render json: "No event was found with id: " << params[:event_id], status: :unprocessable_entity
      end
    end

    def get_vote
      @vote = Vote.where('unique_id' => params[:id]).first
      if !@vote
        vote_not_found(params[:id])
      end
    end

    def get_event_vote
      get_event
      @vote = @event.votes.where('unique_id' => params[:vote_id]).first
      if !@vote
        vote_not_found(params[:vote_id])
      end
    end

    # Message for when no vote exists with given id
    def vote_not_found(id)
      render json: "No vote was found with id: " << id, status: :unprocessable_entity
    end
  
    def vote_params
      unless params[:vote].blank?
       params.require(:vote).permit(:email, :link1, :link2, :link3, :link4, :link5, :date1, :date2, :date3, :confirmed)
      end
    end
end
