module Accounts::ProfilesHelper
  def active_profile_section?(name)
    section = try(:profile_section)
    "active" if controller_name == "profiles" && section == name
  rescue
    # ignored
  end

  def display_preferred_role(role)
    buffer = ActiveSupport::SafeBuffer.new
    buffer << role.title
    buffer << content_tag(:sup, "&dagger;".html_safe)
    buffer
  end
end
