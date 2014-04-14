class Admin::ProfilesController < Admin::BaseController
  def index
    if params[:query].present?
      @profiles = Profile.fuzzy_search params[:query]
    else
      @profiles = Profile.sorted
    end
    respond_to do |format|
      format.html
      format.csv { send_data @profiles.to_csv }
      format.xls
    end
  end

  def show
    @profile = Profile.find params[:id]
    @user = @profile.user
  end
end
