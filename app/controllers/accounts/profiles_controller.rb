class Accounts::ProfilesController < ApplicationController
  layout "accounts"

  def edit
    @profile = current_user.profile || Profile.new
  end

  def create
    @profile = Profile.new params[:profile]
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to edit_profile_path, notice: "Profile successfully created." }
      else
        format.html { render 'edit' }
      end
    end
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes params[:profile]
        format.html { redirect_to edit_profile_path, notice: "Profile successfully updated." }
      else
        format.html { render 'edit' }
      end
    end
  end
end
