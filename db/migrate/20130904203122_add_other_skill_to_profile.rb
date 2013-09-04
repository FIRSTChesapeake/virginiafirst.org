class AddOtherSkillToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :has_other_skill, :boolean, default: false
    add_column :profiles, :other_skill, :string
  end
end
