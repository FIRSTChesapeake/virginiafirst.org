class Volunteer::RegistrationsController < Volunteer::BaseController
  before_filter :authenticate_user!

  def new
    session[:volunteer_params] ||= {}
    @volunteer_form = VolunteerForm.new current_user
    @volunteer_form.current_step = session[:volunteer_step]
  end

  def show
    if current_user.profile
      @profile = current_user.profile
      @events = @profile.volunteer_events
    else
      redirect_to new_volunteer_registration_path(@program)
    end
  end

  def create
    session[:volunteer_params].deep_merge!(params[:profile]) if params[:profile]
    @volunteer_form = VolunteerForm.new current_user
    @volunteer_form.current_step = session[:volunteer_step]
    @volunteer_form.assign_attributes session[:volunteer_params]

    saved = false

    if @volunteer_form.valid?
      if params[:back_button]
        @volunteer_form.previous_step
      elsif @volunteer_form.last_step?
        saved = @volunteer_form.submit if @volunteer_form.all_valid?
      else
        @volunteer_form.next_step
      end
      session[:volunteer_step] = @volunteer_form.current_step
    end

    respond_to do |format|
      if saved
        session[:volunteer_step] = session[:volunteer_params] = nil
        format.html { redirect_to volunteer_registration_path(@program), notice: "Personal profile successfully created." }
      else
        format.html { render :new }
      end
    end
  end

end
