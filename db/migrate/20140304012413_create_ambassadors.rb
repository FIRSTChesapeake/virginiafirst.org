class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.references :profile
      t.references :event

      t.timestamps
    end
    add_index :ambassadors, :profile_id
    add_index :ambassadors, :event_id
  end
end
