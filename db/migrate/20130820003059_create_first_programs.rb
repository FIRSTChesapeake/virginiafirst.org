class CreateFirstPrograms < ActiveRecord::Migration
  def change
    create_table :first_programs do |t|
      t.string :name
      t.string :abbr
      t.string :code
      t.string :icon
      t.string :flag

      t.timestamps
    end
  end
end
