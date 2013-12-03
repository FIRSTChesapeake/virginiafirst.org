class AddStatusToVolunteerRegistration < ActiveRecord::Migration
  def change
    add_column :volunteer_registrations, :status, :string
    add_column :volunteer_registrations, :received_event_info, :boolean
    add_column :volunteer_registrations, :received_assignment, :boolean
    add_column :volunteer_registrations, :received_followup, :boolean
  end
end
