module ApplicationHelper
  def active_class?(name)
    controller_name == name ? "active" : ""
  end

  def display_address(address)
    buffer = ActiveSupport::SafeBuffer.new
    content_tag :address do
      if address.street.present?
        buffer << address.street
        buffer << content_tag(:br)
      end
      if address.city.present?
        buffer << address.city
        buffer << ", "
      end
      buffer << "#{address.state} " if address.state.present?
      buffer << address.zip if address.zip.present?
      buffer
    end
  end

  def display_phone(number)
    has_area_code = number.present? ? number.length > 7 : false
    number_to_phone(number, area_code: has_area_code)
  end

  def us_states
    [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
    ]
  end

  def first
    "<strong><em>FIRST</em></strong>".html_safe
  end

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
  def virginia_first
    "Virginia<strong><em>FIRST</em></strong>".html_safe
  end

  def yes_no(value)
    value ? "Yes" : "No"
  end
end
