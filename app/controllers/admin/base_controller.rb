class Admin::BaseController < ApplicationController
  layout "admin"
  before_filter :load_program

  protected

  def load_program
    @program = FirstProgram.find_by_code params[:program] if params[:program].present?
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end