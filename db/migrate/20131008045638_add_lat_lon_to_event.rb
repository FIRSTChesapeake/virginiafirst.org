class AddLatLonToEvent < ActiveRecord::Migration
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_index :events, [:latitude, :longitude]
  end
end
