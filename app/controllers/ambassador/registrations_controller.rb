class Ambassador::RegistrationsController < ApplicationController
  def new
    @ambassador_form = AmbassadorForm.new
  end
end
