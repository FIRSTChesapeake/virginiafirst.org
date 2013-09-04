class Admin::RolesController < AdminController
  before_filter :authenticate_user!

  def index
    @roles = Role.order(:title)
  end

  def show
    @role = Role.find params[:id]
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new params[:role]

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_roles_path, notice: "Role successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @role = Role.find params[:id]
  end

  def update
    @role = Role.find params[:id]
    respond_to do |format|
      if @role.update_attributes params[:role]
        format.html { redirect_to admin_roles_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @role = Role.find params[:id]
    @role.destroy
    redirect_to admin_roles_path
  end
end
