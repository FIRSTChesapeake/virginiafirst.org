class CheckInPdf < Prawn::Document
  def initialize(event, registrations)
    super(page_layout: :landscape)
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
    table registration_rows, width: bounds.width do
      row(0).font_style = :bold
      columns(3..4).align = :center
      column(3).width = 70;
      column(4).width = 70;
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def registration_rows
    [['Name', 'Assignment(s)', 'Reports To', 'Shirt Size', 'Checked in?']] +
        @registrations.map do |registration|
          [registration.full_name,
           registration.positions.map { |p| p.title }.join(', '),
           registration.reports_to.map(&:full_name).join(', '),
           registration.profile.shirt_size_label,
           '']
        end
  end

end
