class Admin::EventsController < AdminController
  before_filter :load_event, only: [:edit, :update, :show, :destroy]

  def index
    if @program.present?
      @events = @program.events
    else
      @events = Event.all
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new params[:event]
    @event.program = @program if @program.present?

    respond_to do |format|
      if @event.save
        format.html { redirect_to admin_event_path(@program, @event), notice: "Event created successfully." }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update_attributes params[:event]
        format.html { redirect_to admin_event_path(@program, @event), notice: "Event updated successfully." }
      else
        format.html { render 'edit' }
      end
    end
  end

  def show
  end

  def destroy
    @event.destroy

    redirect_to admin_events_path(@program)
  end

  private

  def load_event
    if @program.present?
      @event = @program.events.find params[:id]
    else
      @event = Event.find params[:id]
    end
  end
end