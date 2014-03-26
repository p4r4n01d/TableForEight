class EventsController < ApplicationController
  
    before_filter :fetch_user, :except => [:index, :create]
  
  # GET /api/events (.:format)
  def index
	@events = Event.all
	respond_to do |format|
	  format.json { render json: @events }
	end
  end

  # GET /api/events/:id/ (.:format)
  def show
	respond_to do |format|
	  format.json { render json: @event }
	end
  end

  # POST /api/events (.:format)
  def create
	@event = Event.new(resource_params)
	respond_to do |format|
	  if @event.save
		format.json { render :json=>{:status=>'created',:events=>{:id=>@event.id}}}
	  else
		format.json { render json: @event.errors.full_messages, data: @event, status: :unprocessable_entity }
	  end
	end
  end

  # PATCH /api/events/:id (.:format)
  def update
	respond_to do |format|
	  if @event.update_attributes(resource_params)
		format.json { head :no_content, status: :ok }
	  else
		format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
	  end
	end
  end

  # PUT /api/events/:id (.:format)
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
  
  def resource_params
	unless params[:event].blank?
	  params.require(:event).permit(:date, :cutoff_at, :link1, :name1, :link2, :name2, :link3, :name3, :link4, :name4, :link5, :name5, :date1, :date2, :date3, :hash, :organiser_email, :organiser_name)
	end
  end
end
