class AddSearchIndexToProfile < ActiveRecord::Migration
  def up
    execute "create extension pg_trgm"
    execute "create index profiles_first_name on profiles using gin(to_tsvector('english', first_name))"
    execute "create index profiles_last_name on profiles using gin(to_tsvector('english', last_name))"
    execute "create index profiles_current_organization on profiles using gin(to_tsvector('english', current_organization))"
    execute "create index profiles_current_occupation on profiles using gin(to_tsvector('english', current_occupation))"
  end

  def down
    execute "drop index profiles_first_name"
    execute "drop index profiles_last_name"
    execute "drop index profiles_current_organization"
    execute "drop index profiles_current_occupation"
  end
end
