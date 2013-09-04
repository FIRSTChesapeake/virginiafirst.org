class ChangeStrengthsOnProfile < ActiveRecord::Migration
  def up
    add_column :profiles, :is_administrative, :boolean, default: false
    add_column :profiles, :is_interpersonal, :boolean, default: false
    add_column :profiles, :is_mechanical, :boolean, default: false
    add_column :profiles, :is_technical, :boolean, default: false

    remove_column :profiles, :administrative_skill
    remove_column :profiles, :interpersonal_skill
    remove_column :profiles, :mechanical_skill
    remove_column :profiles, :technical_skill
  end

  def down
    remove_column :profiles, :is_administrative
    remove_column :profiles, :is_interpersonal
    remove_column :profiles, :is_mechanical
    remove_column :profiles, :is_technical

    add_column :profiles, :administrative_skill, :string
    add_column :profiles, :interpersonal_skill, :string
    add_column :profiles, :mechanical_skill, :string
    add_column :profiles, :technical_skill, :string
  end
end
