class Volunteer::ReportsController < ApplicationController
  before_filter :authenticate_user!
  layout 'event'

  def crew_break_down
    @event = Event.includes(:positions).find params[:event_id]
    @key_positions = @event.positions.includes([:role]).where(volunteer_roles: { key_position: true })

    authorize! :read, @event
  end

  def nametags
    @event = Event.includes([:game, :program]).find params[:event_id]
    @volunteers = @event.volunteer_registrations.active

    respond_to do |format|
      format.pdf do
        pdf = NametagsPdf.new @event, @volunteers, view_context
        filename = "#{@event.program.code}_#{@event.code.downcase}_nametags.pdf"
        send_data pdf.render,
                  filename: filename,
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def shirts
    @event = Event.find params[:event_id]
    @shirt_data = @event.shirts_needed.map { |k, v| {size: k.nil? ? "Unknown" : k, count: v} }

    authorize! :read, @event

    respond_to do |format|
      format.html
      format.json { render json: { event: @event, shirts: @shirt_data } }
    end
  end
end
