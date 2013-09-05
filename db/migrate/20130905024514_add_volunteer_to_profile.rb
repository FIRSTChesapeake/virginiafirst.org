class AddVolunteerToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :is_volunteer, :boolean
  end
end
