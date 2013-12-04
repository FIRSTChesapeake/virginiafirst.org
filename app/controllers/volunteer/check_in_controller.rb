class Volunteer::CheckInController < Volunteer::BaseController
  before_filter :authenticate_user!
  layout 'event'

  def index
    @event = Event.find params[:event_id]
    @registrations = @event.volunteer_registrations.includes([:profile, {:assignments => {:position => :role}}]).order("profiles.first_name, profiles.last_name")

    authorize! :read, @event
  end
end
