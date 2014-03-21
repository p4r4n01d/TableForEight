class EventsController < ApplicationController

  http_basic_authenticate_with :name => "test", :password => "test1234"

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_user, :except => [:index, :create]

  def fetch_user
	@events = Event.find_by_id(params[:id])
  end

  def index
	@events = Event.all
	respond_to do |format|
	  format.json { render json: @events }
	end
  end

  def show
	respond_to do |format|
	  format.json { render json: @event }
	end
  end

  def create
	@events = User.new(params[:event])
	@events.temp_password = Devise.friendly_token
	respond_to do |format|
	  if @events.save
		format.json { render json: @event, status: :created }
	  else
		format.json { render json: @event.errors, status: :unprocessable_entity }
	  end
	end
  end

  def update
	respond_to do |format|
	  if @event.update_attributes(params[:event])
		format.json { head :no_content, status: :ok }
	  else
		format.json { render json: @event.errors, status: :unprocessable_entity }
	  end
	end
  end

  def destroy
	respond_to do |format|
	  if @event.destroy
		format.json { head :no_content, status: :ok }
	  else
		format.json { render json: @event.errors, status: :unprocessable_entity }
	  end
	end
  end
end
