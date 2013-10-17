module Volunteer::RegistrationsHelper
  def display_preferred_role(role)
    buffer = ActiveSupport::SafeBuffer.new
    buffer << role.title
    buffer << content_tag(:sup, "&dagger;".html_safe) if role.key_position?
    buffer
  end
end