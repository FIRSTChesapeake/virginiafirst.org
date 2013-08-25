class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :program_id
      t.string :name
      t.integer :season
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :logo

      t.timestamps
    end

    add_index :games, :program_id
  end
end
