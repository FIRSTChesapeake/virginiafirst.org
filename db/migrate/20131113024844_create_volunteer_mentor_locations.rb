class CreateVolunteerMentorLocations < ActiveRecord::Migration
  def change
    create_table :volunteer_mentor_locations do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.references :profile

      t.timestamps
    end
    add_index :volunteer_mentor_locations, :profile_id
  end
end
