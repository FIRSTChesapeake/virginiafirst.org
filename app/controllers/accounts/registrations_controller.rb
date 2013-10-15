class Accounts::RegistrationsController < ApplicationController
  before_filter :authenticate_user!
  layout "accounts"

  def index
    @profile = current_user.profile
    @registrations = @profile.volunteer_registrations.includes(:event)
  end

  def destroy
    @profile = current_user.profile
    @registration = @profile.volunteer_registrations.find params[:id]
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to my_events_path, notice: "Your volunteer registration was successfully deleted." }
    end
  end

end
