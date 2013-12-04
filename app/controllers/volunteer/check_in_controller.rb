class Volunteer::CheckInController < Volunteer::BaseController
  before_filter :authenticate_user!
  layout 'event'

  def index
    @event = Event.find params[:event_id]
    @registrations = @event.volunteer_registrations.includes([:profile, {:assignments => {:position => :role}}]).order("profiles.first_name, profiles.last_name")

    authorize! :read, @event

    respond_to do |format|
      format.html
      format.pdf do
        pdf = CheckInPdf.new @event, @registrations
        filename = "#{@event.program.code}_#{@event.code.downcase}_check_in.pdf"
        send_data pdf.render,
                  filename: filename,
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end
end
