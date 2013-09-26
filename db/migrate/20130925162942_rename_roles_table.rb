class RenameRolesTable < ActiveRecord::Migration
  def up
    rename_table :roles, :volunteer_roles
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
