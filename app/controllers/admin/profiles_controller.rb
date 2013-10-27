class Admin::ProfilesController < Admin::BaseController
  def index
    @profiles = Profile.sorted
  end

  def show
    @profile = Profile.find params[:id]
    @user = @profile.user
  end
end
