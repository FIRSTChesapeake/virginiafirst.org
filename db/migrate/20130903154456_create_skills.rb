class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.boolean :is_technical
      t.boolean :is_mechanical
      t.boolean :is_administrative

      t.timestamps
    end
  end
end
