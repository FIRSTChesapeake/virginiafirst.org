module Volunteer::RegistrationsHelper
  def print_address(event)
    fields = [event.venue, event.street, event.city, event.state, event.zip]
    fields.delete_if { |item| item.blank? }
    content_tag :address, fields.join(", ")
  end
end