class CreateVolunteerAssignments < ActiveRecord::Migration
  def change
    create_table :volunteer_assignments do |t|
      t.references :registration
      t.references :position
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
    add_index :volunteer_assignments, :position_id
    add_index :volunteer_assignments, :registration_id
  end
end
