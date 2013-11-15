class AddMentorPrefsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :wants_to_mentor, :boolean
  end
end
