class SetDefaultNumberNeededInVolunteerPositions < ActiveRecord::Migration
  def up
    change_column :volunteer_positions, :needed_count, :integer, default: 1
  end

  def down
    change_column :volunteer_positions, :needed_count, :integer, default: nil
  end
end
