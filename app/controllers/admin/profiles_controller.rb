class Admin::ProfilesController < Admin::BaseController
  def index
    @profiles = Profile.includes(:user)
      .search_by_name(params[:query])
      .search_by_program(params[:first_program])
      .sorted

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
