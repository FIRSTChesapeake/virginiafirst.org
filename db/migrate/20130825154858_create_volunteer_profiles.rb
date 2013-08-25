class CreateVolunteerProfiles < ActiveRecord::Migration
  def change
    create_table :volunteer_profiles do |t|
      t.integer :user_id
      t.string :age
      t.string :occupation
      t.string :organization
      t.string :technical_skill
      t.string :administrative_skill
      t.string :interpersonal_skill
      t.string :mechanical_skill
      t.text :first_experience
      t.text :volunteer_experience
      t.boolean :confirmed_age
      t.string :shirt_size

      t.timestamps
    end

    add_index :volunteer_profiles, :user_id
  end
end
