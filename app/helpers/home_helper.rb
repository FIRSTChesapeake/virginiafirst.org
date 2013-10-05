module HomeHelper
  def display_location(event)
    buffer = ActiveSupport::SafeBuffer.new
    buffer << "<address>".html_safe
    buffer << "#{event.venue}<br>".html_safe if event.venue.present?
    buffer << "#{event.city}, #{event.state}"
    buffer << "</address>".html_safe
    buffer
  end
end
