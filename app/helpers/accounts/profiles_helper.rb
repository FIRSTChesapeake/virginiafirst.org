module Accounts::ProfilesHelper
  def active_profile_section?(name)
    section = try(:profile_section)
    "active" if controller_name == "profiles" && section == name
  rescue
    # ignored
  end
end
