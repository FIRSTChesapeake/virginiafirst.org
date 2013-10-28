class Admin::ProfilesController < Admin::BaseController
  def index
    if params[:query].present?
      @profiles = Profile.fuzzy_search params[:query]
    else
      @profiles = Profile.sorted
    end
  end

  def show
    @profile = Profile.find params[:id]
    @user = @profile.user
  end
end
