class Volunteer::AssignmentsController < ApplicationController
  load_and_authorize_resource

  def create
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to :back }
        format.js { @position = @assignment.position }
      end
    end
  end

  def destroy
    @volunteer = Volunteer::Registration.includes({:event => :roles}).find @assignment.registration_id
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
