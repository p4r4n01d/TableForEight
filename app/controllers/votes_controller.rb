class VotesController < ApplicationController

  before_filter :get_event, :except => [:destroy, :update, :show]
  before_filter :get_vote, :except => [:index, :destroy, :update, :create, :countvotes]
  before_filter :get_event_vote, :except => [:index, :show, :create, :countvotes]
    
  # GET /events/:event_id/votes/:id .find(:all)
  def index
    respond_to do |format|
      format.json { render :json => {:events => @event, :votes => @event.votes}}
    end
  end

  # GET /events/:event_id/votes
  def show
    respond_to do |format|
      format.json { render json: @event.votes }
    end
  end

  # GET /events/:event_id/countvotes
  def countvotes
    respond_to do |format|
      format.json { render json: @event.votes.get_votes_sum(params[:event_id]) }
    end
  end

  # POST /events/:event_id/votes
  def create
    @vote = @event.votes.create(vote_params)
    respond_to do |format|
      if @vote.save
        UserMailer.welcome_email(@vote, @event).deliver
        format.json { render :json => {:status => 'created',
          :events => {:id => @vote.id}}}
      else
        format.json { render json: @vote.errors.full_message,
          status: :unprocessable_entity }
      end
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
  end

  # PUT /votes/:vote_id
  def update
    respond_to do |format|
      if !!@vote && @vote.update_attributes(vote_params)
        format.json { render :json => {:status => 'ok',
          :events => {:id => @vote.id}}}
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_event
      @event = Event.find_by_id(params[:event_id])
      if !!@event
        render json: "No event was found with id: " << params[:event_id],
          status: :unprocessable_entity
      end
    end

    def get_vote
      @vote = Vote.find_by_id(params[:id])
      if !!@vote
        vote_not_found(params[:vote_id])
      end
    end
    
    def get_event_vote
      get_event
      @vote = @event.votes.find_by_id(params[:vote_id])
      if !!@vote
        vote_not_found(params[:vote_id])
      end
    end

    def vote_not_found(id)
      render json: "No vote was found with id: " << id,
          status: :unprocessable_entity
    end

    def vote_params
      unless params[:vote].blank?
       params.require(:vote).permit(:email, :link1, :link2, :link3, :link4, :link5, :date1, :date2, :date3, :confirmed)
      end
    end
end
