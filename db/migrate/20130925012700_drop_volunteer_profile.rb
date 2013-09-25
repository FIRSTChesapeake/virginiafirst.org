class DropVolunteerProfile < ActiveRecord::Migration
  def up
    drop_table :volunteer_profiles
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
