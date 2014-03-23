class EventsController < ApplicationController

  http_basic_authenticate_with :name => "test", :password => "test1234"

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_user, :except => [:index, :create]
  
  #GET /api/events (.:format)
  def index
	@events = Event.all
	respond_to do |format|
	  format.json { render json: @events }
	end
  end

  #GET /api/events/:id/ (.:format)
  def show
	respond_to do |format|
	  format.json { render json: @event }
	end
  end

  def create
	@event = Event.new(params[:event])
	#@event.temp_password = Devise.friendly_token
	respond_to do |format|
	  if @event.save
		format.json { render json: @event, status: :created }
	  else
		format.json { render json: @event.errors.full_messages, data: @event, status: :unprocessable_entity }
	  end
	end
  end

  def update
	respond_to do |format|
	  if @event.update_attributes(params[:event])
		format.json { head :no_content, status: :ok }
	  else
		format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
	  end
	end
  end

  def destroy
	respond_to do |format|
	  if @event.destroy
		format.json { head :no_content, status: :ok }
	  else
		format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
	  end
	end
  end
  
  private
  def fetch_user
	@event = Event.find_by_id(params[:id])
  end
end
