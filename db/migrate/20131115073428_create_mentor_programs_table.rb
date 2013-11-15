class CreateMentorProgramsTable < ActiveRecord::Migration
  def change
    create_table :volunteer_mentor_programs, id: false do |t|
      t.integer :profile_id
      t.integer :program_id
    end
  end
end
