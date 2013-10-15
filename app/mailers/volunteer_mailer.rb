class VolunteerMailer < ActionMailer::Base
  add_template_helper ApplicationHelper

  default from: 'VirginiaFIRST <no-reply@volunteer.virginiafirst.org>'

  def registration(profile)
    @profile = profile
    @user = profile.user

    mail to: @user.email, subject: "VirginiaFIRST Volunteer Registration"
  end
end
