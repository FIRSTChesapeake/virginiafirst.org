class NametagsPdf < Prawn::Document
  NAMETAG_WIDTH = 243    # 3.375"
  NAMETAG_HEIGHT = 168   # 2 1/3"
  NAMETAG_MARGIN = 8

  def initialize(event, volunteers, view)
    super(top_margin: 40, left_margin: 55)
    @event = event
    @volunteers = volunteers
    @view = view
    nametags
  end

  def nametags
    y_position = cursor
    @volunteers.each_with_index do |volunteer, index|
      y_position = cursor if index.even?
      x_offset = index.odd? ? NAMETAG_WIDTH + 29 : 0
      location = [x_offset, y_position]
      nametag(volunteer, location)
      move_down 13 if index.odd?
      start_new_page if (index+1) % 8 == 0
    end
  end

  def nametag(volunteer, location)
    bounding_box(location, width: NAMETAG_WIDTH, height: NAMETAG_HEIGHT) do
      display_logo
      display_event_name
      move_down 20
      display_volunteer_name(volunteer)
    end
  end

  def display_logo
    image @event.program.icon.path,
          height: 60,
          at: [NAMETAG_MARGIN, NAMETAG_HEIGHT - NAMETAG_MARGIN]
  end

  def display_event_name
    bounding_box([80, NAMETAG_HEIGHT - NAMETAG_MARGIN], width: 155, height: 60 + NAMETAG_MARGIN) do
      font "Helvetica", size: 14, style: :bold do
        text @event.name, align: :center, valign: :center, color: "EC1A23"
      end
    end
  end

  def display_volunteer_name(volunteer)
    font "Helvetica", size: 28, style: :bold do
      text volunteer.first_name, align: :center
    end
    font_size(16) { text volunteer.last_name, align: :center }
  end

end