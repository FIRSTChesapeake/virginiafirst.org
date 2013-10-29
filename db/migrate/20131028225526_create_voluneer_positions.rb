class CreateVoluneerPositions < ActiveRecord::Migration
  def change
    create_table :volunteer_positions do |t|
      t.references :event
      t.references :role
      t.integer :needed_count

      t.timestamps
    end
    add_index :volunteer_positions, :event_id
    add_index :volunteer_positions, :role_id
  end
end
