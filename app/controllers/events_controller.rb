class EventsController < ApplicationController
  
  before_filter :fetch_event, :except => [:index, :create]
  respond_to :json

  # GET /api/events (.:format)
  def index
	respond_with (@events = Event.all)
  end

  # GET /api/events/:id/ (.:format)
  def show
	respond_with @event
  end

  # POST /api/events (.:format)
  def create
	@event = Event.new(event_params)
	if @event.save
	  flash[:notice] = "Event was created successfully."
	  UserMailer.admin_welcome_email(@event).deliver
	end
    respond_with(@event)
  end

  # PATCH /api/events/:id (.:format)
  def update
	respond_to do |format|
	  if @event.present? && @event.update_attributes(event_params)
	    format.json { render json: @event, status: :ok }
	  else
	    format.json { render json: db_op_failed,
	        status: :unprocessable_entity }
	  end
	end
  end

  # PUT /api/events/:id (.:format)
  def destroy
	respond_to do |format|
	  if @event.present? && @event.destroy
		format.json { head :no_content, status: :ok }
	  else
	    format.json { render json: db_op_failed,
	        status: :unprocessable_entity }
	  end
	end
  end

  private
  def fetch_event
	@event = Event.where('unique_id' => params[:id]).first
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
