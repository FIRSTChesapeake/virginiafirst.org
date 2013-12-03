class Volunteer::CheckInController < Volunteer::BaseController
  before_filter :authenticate_user!
  layout 'event'

  def index
    @event = Event.find params[:event_id]
    @registrations = @event.volunteer_registrations.includes({:assignments => {:position => :role}})

    authorize! :read, @event
  end
end
