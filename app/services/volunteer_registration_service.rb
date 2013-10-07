class VolunteerRegistrationService
  attr_accessor :profile

  def initialize(profile)
    @profile = profile
  end


  def register_and_notify(registration_params)
    if @profile.update_attributes(registration_params)
      VolunteerMailer.registration(@profile).deliver
      true
    else
      false
    end
  end
end