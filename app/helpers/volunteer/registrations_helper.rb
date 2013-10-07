module Volunteer::RegistrationsHelper
  def print_address(event)
    fields = [event.street, event.city, event.state, event.zip]
    fields.delete_if { |item| item.blank? }
    buffer = ActiveSupport::SafeBuffer.new
    buffer << "<address>".html_safe
    buffer << "#{event.venue}<br>".html_safe if event.venue.present?
    buffer << fields.join(", ")
    buffer << "</address>".html_safe
    buffer
  end
end