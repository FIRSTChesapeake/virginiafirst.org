class AddProgramIdToVolunteerRole < ActiveRecord::Migration
  def change
    add_column :volunteer_roles, :program_id, :integer
  end
end
