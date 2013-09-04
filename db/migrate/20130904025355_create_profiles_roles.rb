class CreateProfilesRoles < ActiveRecord::Migration
  def change
    create_table :profiles_roles, id: false do |t|
      t.references :profile
      t.references :role
    end

    add_index :profiles_roles, [:profile_id, :role_id]
  end
end
