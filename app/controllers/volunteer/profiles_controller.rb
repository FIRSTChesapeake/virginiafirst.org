class Volunteer::ProfilesController < ApplicationController
  before_filter :authenticate_user!
  layout 'event'

  def index
    @event = Event.find params[:event_id]
    @profiles = @event.volunteer_profiles.includes(:user)

    authorize! :read, @event
    authorize! :read, Profile
  end

  def show
    @event = Event.find params[:event_id]
    @profile = @event.volunteer_profiles.find params[:id]

    authorize! :read, @event
    authorize! :read, @profile
  end
end
