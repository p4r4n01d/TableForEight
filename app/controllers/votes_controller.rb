class VotesController < ApplicationController

  before_filter :get_event, :except => [:destroy, :update, :show]
  before_filter :get_vote, :except => [:index, :update, :create, :countvotes]
  before_filter :get_event_vote, :except => [:index, :show, :create, :countvotes, :destroy]
    
  # GET /api/events/:event_id/votes
  def index
    respond_to do |format|
      format.json { render :json => {:events => @event, :votes => @event.votes}}
    end
  end

  # GET /api/votes/:id
  def show
    respond_to do |format|
      format.json { render json: @vote }
    end
  end

  # GET /api/get/:event_id
  def countvotes
    respond_to do |format|
      format.json { render json: @event.votes.get_count_details(params[:event_id]) }
    end
  end

  # POST /api/events/:event_id/votes
  def create
    @vote = @event.votes.create(vote_params)
    respond_to do |format|
      if @vote.save
        UserMailer.welcome_email(@vote, @event).deliver
        UserMailer. admin_welcome_email(@event).deliver
        format.json { render :json => {:status => 'created',
          :events => {:id => @vote.id}}, status: :created}
      else
        format.json { render json: @vote.errors.full_messages,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/votes/:vote_id
  def destroy
    respond_to do |format|
      if @vote.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @vote.errors.full_messages,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /api/votes/:vote_id
  def update
    respond_to do |format|
      if !!@vote && @vote.update_attributes(vote_params)
        format.json { render :json => {:status => 'ok',
          :events => {:id => @vote.id}}}
      else
        format.json { render json: @vote.errors.full_messages,
          status: :unprocessable_entity }
      end
    end
  end

  private
    def get_event
      @event = Event.find_by_id(params[:event_id])
      if !@event
        render json: "No event was found with id: " << params[:event_id],
          status: :unprocessable_entity
      end
    end

    def get_vote
      @vote = Vote.find_by_id(params[:id])
      if !@vote
        vote_not_found(params[:id])
      end
    end

    def get_event_vote
      get_event
      @vote = @event.votes.find_by_id(params[:vote_id])
      if !@vote
        vote_not_found(params[:vote_id])
      end
    end

    # Message for when no vote exists with given id
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
