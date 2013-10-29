class Volunteer::EventsController < Volunteer::BaseController
  before_filter :authenticate_user!
  authorize_resource

  def index
    @events = Event.sorted
  end

  def show
    @event = Event.find params[:id]
  end
end
