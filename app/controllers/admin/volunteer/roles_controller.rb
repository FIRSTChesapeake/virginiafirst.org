class Admin::Volunteer::RolesController < Admin::BaseController
  before_filter :authenticate_user!
  authorize_resource

  def index
    @roles = Volunteer::Role.order(:title)
  end

  def show
    @role = Volunteer::Role.find params[:id]
  end

  def new
    @role = Volunteer::Role.new
  end

  def create
    @role = Volunteer::Role.new params[:volunteer_role]

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_volunteer_roles_path, notice: "Role successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @role = Volunteer::Role.find params[:id]
  end

  def update
    @role = Volunteer::Role.find params[:id]
    respond_to do |format|
      if @role.update_attributes params[:volunteer_role]
        format.html { redirect_to admin_volunteer_roles_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @role = Volunteer::Role.find params[:id]
    @role.destroy
    redirect_to admin_volunteer_roles_path
  end
end
