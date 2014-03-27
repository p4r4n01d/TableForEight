class EventsController < ApplicationController
  
  before_filter :fetch_event, :except => [:index, :create]
  
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
	@event = Event.new(event_params)
	respond_to do |format|
	  # Have to make sure event is non-null first
	  if !!@event && @event.save
		format.json { render :json=>{:status=>'created',:events=>{:id=>@event.id}}}
	  else
	    format.json { render json: db_op_failed(event_params),
	        status: :unprocessable_entity }
	  end
	end
  end

  # PATCH /api/events/:id (.:format)
  def update
	respond_to do |format|
	  if !!@event && @event.update_attributes(event_params)
		format.json { head :no_content, status: :ok }
	  else
	    format.json { render json: db_op_failed,
	        status: :unprocessable_entity }
	  end
	end
  end

  # PUT /api/events/:id (.:format)
  def destroy
	respond_to do |format|
	  if !!@event && @event.destroy
		format.json { head :no_content, status: :ok }
	  else
	    format.json { render json: db_op_failed,
	        status: :unprocessable_entity }
	  end
	end
  end
  
  private
  def fetch_event
	@event = Event.find_by_id(params[:id])
  end
  
  def db_op_failed(id=params[:id])
  	!@event ? no_such_event(id) : @event.errors.full_messages
  end

  def no_such_event(id)
    if id.is_a? Hash
      {"message" => "Could not process event", :event => id}
    else
      {"message" => "No event could be found with id: " << id}
    end
  end

  def event_params
	unless params[:event].blank?
	  params.require(:event).permit(:date, :cutoff_at, :link1, :name1, :link2, :name2, :link3, :name3, :link4, :name4, :link5, :name5, :date1, :date2, :date3, :hash, :organiser_email, :organiser_name)
	end
  end
end
