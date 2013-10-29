class Volunteer::BaseController < ApplicationController
  before_filter :load_program

  private

  def load_program
    @program = FirstProgram.find_by_code params[:program] if params[:program].present?
    if @program.present?
      @programs = [@program]
    else
      @programs = FirstProgram.with_upcoming_events
    end
  end
end