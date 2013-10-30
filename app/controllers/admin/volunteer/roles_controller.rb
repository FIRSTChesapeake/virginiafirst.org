class Admin::Volunteer::RolesController < Admin::BaseController
  authorize_resource

  def index
    if @program.present?
      @roles = Volunteer::Role.where(program_id: [nil, @program.id]).order(:title)
    else
      @roles = Volunteer::Role.order(:title)
    end
  end

  def show
    @role = Volunteer::Role.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @role }
    end
  end

  def new
    @role = Volunteer::Role.new

    respond_to do |format|
      format.html
      format.json { render json: @role }
    end
  end

  def create
    @role = Volunteer::Role.new params[:volunteer_role]
    @role.program = @program if @program.present?

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_volunteer_roles_path(@program), notice: "Role successfully created." }
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
        format.html { redirect_to admin_volunteer_roles_path(@program) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @role = Volunteer::Role.find params[:id]
    @role.destroy
    redirect_to admin_volunteer_roles_path(@program)
  end
end
