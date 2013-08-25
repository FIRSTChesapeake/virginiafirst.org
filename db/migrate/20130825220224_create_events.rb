class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :program_id
      t.string :name
      t.datetime :starts_at
      t.datetime :setup_at
      t.datetime :teardown_at
      t.string :venue
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.integer :participant_limit

      t.timestamps
    end

    add_index :events, :program_id
  end
end
