class VotesController < ApplicationController

  before_filter :get_vote, :except => [:index, :show, :create, :countvotes]
  before_filter :get_event, :except => [:destroy, :update]
    
  # GET /events/:event_id/votes/:id
  def index
  @votes = @event.votes
  respond_to do |format|
    format.json { render :json=>{:events=>@event,:votes=>@votes}}
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
    render json: @event.Vote.count_votes
  end

  # POST /events/:event_id/votes
  def create
    @vote = @event.votes.create(vote_params)
    respond_to do |format|
      if @vote.save
        UserMailer.welcome_email(@vote, @event).deliver
        format.json { render :json=>{:status=>'created',:events=>{:id=>@vote.id}}}
      else
        format.json { render json: @vote.errors.full_message, status: :unprocessable_entity }
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
      if @vote.update_attributes(params[:vote])
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_event
      @event = Event.find_by_id(params[:event_id])
    end

    def get_vote
      @vote = Vote.find_by_id(params[:id])
    end

    def vote_params
      params.require(:vote).permit(:email, :link1, :link2, :link3, :link4, :link5, :date1, :date2, :date3, :confirmed)
    end
end
