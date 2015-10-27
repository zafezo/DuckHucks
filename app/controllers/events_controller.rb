class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit,:update,:destroy]


  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    case params[:type]
    when "myc"
      @events = Event.where(user_id: current_user.id)
    when "myj"
      @events = Event.joins(:members).where(:members => {user_id: current_user.id})
    end
end
  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @head_user = User.find(@event.user_id)
  end

  # GET /events/new
  def new
    @event = Event.new
    @categories = Category.all
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.latitude = request.location.latitude
    @event.longitude = request.location.longitude
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @event = Event.find(params[:id])
    unless @event.user == current_user 
      Member.create!(event_id: @event.id,
                      user_id: current_user.id)
      flash[:success] = "You join this event"
    end
    redirect_to @event
  end

  def leave
    @event = Event.find(params[:id])
    unless @event.user == current_user 
     m =  Member.where(event_id:@event.id, 
        user_id: current_user.id)[0]
     unless m.blank?
      m.destroy() 
      flash[:danger] = "You leave event"
    end
    end
    redirect_to @event
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :user_id,:category_id,:time)
    end


      def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless correct_user?(@user)
    end
end
