class Volunteer::ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @event = Event.find params[:event_id]
    @profiles = @event.volunteer_profiles.includes(:user)

    authorize! :read, @event
    authorize! :read, Profile

    render layout: 'event'
  end

  def show
    @profile = Profile.find params[:id]

    authorize! :read, @profile
  end
end
