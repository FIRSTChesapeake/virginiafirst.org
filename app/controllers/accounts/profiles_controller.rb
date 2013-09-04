class Accounts::ProfilesController < ApplicationController
  layout "accounts"

  helper_method :profile_section

  def edit
    @profile = current_user.profile || Profile.new
    render profile_section
  end

  def create
    @profile = Profile.new params[:profile]
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to edit_profile_path, notice: "#{profile_description} successfully created." }
      else
        format.html { render profile_section }
      end
    end
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes params[:profile]
        section = profile_route
        format.html { redirect_to [:edit, section], notice: "#{profile_description} successfully updated." }
      else
        format.html { render profile_section }
      end
    end
  end

  private

  def profile_description
    profile_route.to_s.humanize.capitalize
  end

  def profile_path
    path = request.fullpath.split("?")[0] # strip off query parameters
    path.split("/")[2]
  end

  def profile_route
    case profile_path
      when "personal"
        :profile
      when "background"
        :background_profile
      when "volunteer"
        :volunteer_profile
      else
        :profile
    end
  end

  def profile_section
    profile_path
  end
end
