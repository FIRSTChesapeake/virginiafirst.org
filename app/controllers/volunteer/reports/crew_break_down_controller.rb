class Volunteer::Reports::CrewBreakDownController < ApplicationController
  layout 'event'

  def show
    @event = Event.includes(:positions).find params[:event_id]
    @key_positions = @event.positions.includes([:role]).where(volunteer_roles: { key_position: true })

    authorize! :read, @event
  end
end
