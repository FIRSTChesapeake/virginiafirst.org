class Volunteer::ReportsController < ApplicationController
  before_filter :authenticate_user!
  layout 'event'

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
