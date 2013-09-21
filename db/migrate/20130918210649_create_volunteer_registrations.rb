class CreateVolunteerRegistrations < ActiveRecord::Migration
  def change
    create_table :volunteer_registrations do |t|
      t.references :profile
      t.references :event
      t.boolean :will_setup
      t.boolean :will_teardown

      t.timestamps
    end
    add_index :volunteer_registrations, :profile_id
    add_index :volunteer_registrations, :event_id
  end
end
