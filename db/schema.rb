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

ActiveRecord::Schema.define(:version => 20130825203622) do

  create_table "auth_providers", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "auth_providers", ["provider", "uid"], :name => "index_auth_providers_on_provider_and_uid", :unique => true
  add_index "auth_providers", ["user_id"], :name => "index_auth_providers_on_user_id"

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
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "volunteer_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "age"
    t.string   "occupation"
    t.string   "organization"
    t.string   "technical_skill"
    t.string   "administrative_skill"
    t.string   "interpersonal_skill"
    t.string   "mechanical_skill"
    t.text     "first_experience"
    t.text     "volunteer_experience"
    t.boolean  "confirmed_age"
    t.string   "shirt_size"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "volunteer_profiles", ["user_id"], :name => "index_volunteer_profiles_on_user_id"

end
