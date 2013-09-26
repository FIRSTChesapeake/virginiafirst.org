class CreateVolunteerRoles < ActiveRecord::Migration
  def change
    # This will get renamed to volunteer_roles later in
    # migration version 20130925162942
    create_table :roles do |t|
      t.string :title
      t.text :description
      t.time :default_checkin_at
      t.time :default_starts_at
      t.time :default_ends_at
      t.integer :default_number_needed
      t.boolean :key_position
      t.integer :reports_to_id

      t.timestamps
    end

    add_index :roles, :reports_to_id
  end
end
