class Volunteer::RegistrationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_program

  def show
    @profile = current_user.profile
    if @program.present?
      @programs = [@program]
    else
      @programs = FirstProgram.with_upcoming_events
    end
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to confirm_registration_path }
      else
        format.html { render :show }
      end
    end
  end

  def profile
  end

  def confirm
  end

  private

  def load_program
    @program = FirstProgram.find_by_code params[:program] if params[:program].present?
  end
end
