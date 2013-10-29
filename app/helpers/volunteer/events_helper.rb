module Volunteer::EventsHelper
  def progress_class(value)
    case value
      when 0..0.5
        "warning"
      when 0.5..0.8
        "info"
      else
        "success"
    end
  end
end
