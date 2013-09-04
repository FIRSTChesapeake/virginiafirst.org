class AddFirstExpToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :has_frc_experience, :boolean
    add_column :profiles, :frc_team_number, :string
    add_column :profiles, :has_ftc_experience, :boolean
    add_column :profiles, :ftc_team_number, :string
    add_column :profiles, :has_fll_experience, :boolean
    add_column :profiles, :has_jrfll_experience, :boolean
    add_column :profiles, :is_student, :boolean
    add_column :profiles, :is_parent, :boolean
    add_column :profiles, :is_mentor, :boolean
    add_column :profiles, :is_sponsor, :boolean
    add_column :profiles, :first_experience, :text
  end
end
