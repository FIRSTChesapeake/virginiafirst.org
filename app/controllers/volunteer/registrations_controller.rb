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

    unless @profile
      redirect_to profile_volunteer_registration_path(@program)
    end
  end

  def update
    @profile = current_user.profile
    @service = VolunteerRegistrationService.new(@profile)

    respond_to do |format|
      if @service.register_and_notify(params[:profile])
        format.html { redirect_to confirm_volunteer_registration_path }
      else
        if @program.present?
          @programs = [@program]
        else
          @programs = FirstProgram.with_upcoming_events
        end
        format.html { render :show }
      end
    end
  end

  def profile
    @profile = Profile.new
  end

  def create
    @profile = Profile.new params[:profile]
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to volunteer_registration_path(@program), notice: "Personal profile successfully created." }
      else
        format.html { render :profile }
      end
    end
  end

  def confirm
    @profile = current_user.profile
    @events = @profile.volunteer_events
  end

  private

  def load_program
    @program = FirstProgram.find_by_code params[:program] if params[:program].present?
  end
end
