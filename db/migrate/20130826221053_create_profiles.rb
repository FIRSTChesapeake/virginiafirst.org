class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.string :age
      t.string :primary_phone_type
      t.string :primary_phone_number
      t.string :alternate_phone_type
      t.string :alternate_phone_number
      t.string :current_organization
      t.string :current_occupation
      t.string :shirt_size
      t.string :administrative_skill
      t.string :interpersonal_skill
      t.string :mechanical_skill
      t.string :technical_skill
      t.text :special_needs
      t.text :volunteer_experience
      t.boolean :first_alumnus
      t.boolean :virginiafirst_alumnus
      t.boolean :confirmed_age

      t.timestamps
    end

    add_index :profiles, :user_id
  end
end
