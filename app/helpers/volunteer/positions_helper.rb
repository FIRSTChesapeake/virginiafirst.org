module Volunteer::PositionsHelper
  def fullfillment_class(position)
    case position.fullfillment
      when 0..0.5
        "important"
      when 0.5..0.8
        "warning"
      when 0.8..0.999
        "info"
      else
        "success"
    end
  end
end