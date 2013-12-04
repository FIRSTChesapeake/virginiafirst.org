class CheckInPdf < Prawn::Document
  def initialize(event, registrations)
    super()
    @event = event
    @registrations = registrations

    header
    check_in_table
  end

  def header
    font "Helvetica", size: 24, style: :bold do
      text @event.name
    end

    font_size(18) { text "Volunteer Check In" }
  end

  def check_in_table
    move_down 20
    table registration_rows do
      row(0).font_style = :bold
      columns(2..3).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def registration_rows
    [['Name', 'Assignment(s)', 'Shirt Size', 'Checked in?']] +
        @registrations.map do |registration|
          [registration.full_name,
           registration.assignments.map { |a| a.position.title }.join(', '),
           registration.profile.shirt_size_label,
           '']
        end
  end

end