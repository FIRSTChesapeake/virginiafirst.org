# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131203230404) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assignments", ["role_id"], :name => "index_assignments_on_role_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "auth_providers", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "auth_providers", ["provider", "uid"], :name => "index_auth_providers_on_provider_and_uid", :unique => true
  add_index "auth_providers", ["user_id"], :name => "index_auth_providers_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "program_id"
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "setup_at"
    t.datetime "teardown_at"
    t.string   "venue"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "participant_limit"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "game_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "events", ["game_id"], :name => "index_events_on_game_id"
  add_index "events", ["latitude", "longitude"], :name => "index_events_on_latitude_and_longitude"
  add_index "events", ["program_id"], :name => "index_events_on_program_id"

  create_table "first_programs", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.string   "code"
    t.string   "icon"
    t.string   "flag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "program_id"
    t.string   "name"
    t.integer  "season"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "games", ["program_id"], :name => "index_games_on_program_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "age"
    t.string   "primary_phone_type"
    t.string   "primary_phone_number"
    t.string   "alternate_phone_type"
    t.string   "alternate_phone_number"
    t.string   "current_organization"
    t.string   "current_occupation"
    t.string   "shirt_size"
    t.text     "special_needs"
    t.text     "volunteer_experience"
    t.boolean  "first_alumnus"
    t.boolean  "virginiafirst_alumnus"
    t.boolean  "confirmed_age"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "has_frc_experience"
    t.string   "frc_team_number"
    t.boolean  "has_ftc_experience"
    t.string   "ftc_team_number"
    t.boolean  "has_fll_experience"
    t.boolean  "has_jrfll_experience"
    t.boolean  "is_student"
    t.boolean  "is_parent"
    t.boolean  "is_mentor"
    t.boolean  "is_sponsor"
    t.text     "first_experience"
    t.boolean  "is_administrative",      :default => false
    t.boolean  "is_interpersonal",       :default => false
    t.boolean  "is_mechanical",          :default => false
    t.boolean  "is_technical",           :default => false
    t.boolean  "has_other_skill",        :default => false
    t.string   "other_skill"
    t.boolean  "is_volunteer"
    t.boolean  "wants_to_mentor"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "profiles_roles", :id => false, :force => true do |t|
    t.integer "profile_id"
    t.integer "role_id"
  end

  add_index "profiles_roles", ["profile_id", "role_id"], :name => "index_profiles_roles_on_profile_id_and_role_id"

  create_table "profiles_skills", :id => false, :force => true do |t|
    t.integer "profile_id"
    t.integer "skill_id"
  end

  add_index "profiles_skills", ["profile_id", "skill_id"], :name => "index_profiles_skills_on_profile_id_and_skill_id"

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.boolean  "is_technical"
    t.boolean  "is_mechanical"
    t.boolean  "is_administrative"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "volunteer_assignments", :force => true do |t|
    t.integer  "registration_id"
    t.integer  "position_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "volunteer_assignments", ["position_id"], :name => "index_volunteer_assignments_on_position_id"
  add_index "volunteer_assignments", ["registration_id"], :name => "index_volunteer_assignments_on_registration_id"

  create_table "volunteer_mentor_locations", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "profile_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "volunteer_mentor_locations", ["profile_id"], :name => "index_volunteer_mentor_locations_on_profile_id"

  create_table "volunteer_mentor_programs", :id => false, :force => true do |t|
    t.integer "profile_id"
    t.integer "program_id"
  end

  create_table "volunteer_positions", :force => true do |t|
    t.integer  "event_id"
    t.integer  "role_id"
    t.integer  "needed_count"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "volunteer_positions", ["event_id"], :name => "index_volunteer_positions_on_event_id"
  add_index "volunteer_positions", ["role_id"], :name => "index_volunteer_positions_on_role_id"

  create_table "volunteer_registrations", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "event_id"
    t.boolean  "will_setup"
    t.boolean  "will_teardown"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "status"
    t.boolean  "received_event_info"
    t.boolean  "received_assignment"
    t.boolean  "received_followup"
  end

  add_index "volunteer_registrations", ["event_id"], :name => "index_volunteer_registrations_on_event_id"
  add_index "volunteer_registrations", ["profile_id"], :name => "index_volunteer_registrations_on_profile_id"

  create_table "volunteer_roles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.time     "default_checkin_at"
    t.time     "default_starts_at"
    t.time     "default_ends_at"
    t.integer  "default_number_needed"
    t.boolean  "key_position"
    t.integer  "reports_to_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "program_id"
  end

  add_index "volunteer_roles", ["reports_to_id"], :name => "index_roles_on_reports_to_id"

end
