class Admin::SkillsController < Admin::BaseController
  before_filter :authenticate_user!
  authorize_resource

  def index
    @skills = Skill.order(:name)
  end

  def show
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new params[:skill]

    respond_to do |format|
      if @skill.save
        format.html { redirect_to admin_skills_path, notice: "Skill successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @skill = Skill.find params[:id]
  end

  def update
    @skill = Skill.find params[:id]
    respond_to do |format|
      if @skill.update_attributes params[:skill]
        format.html { redirect_to admin_skills_path, notice: "Skill successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @skill = Skill.find params[:id]
    @skill.destroy
    redirect_to admin_skills_path, notice: "Skill successfully deleted."
  end
end
