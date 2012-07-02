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

ActiveRecord::Schema.define(:version => 20120209174715) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.text     "difference", :default => ""
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["event_id"], :name => "index_comments_on_event_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "city"
    t.string   "street"
    t.integer  "building_number"
    t.boolean  "confirmation",    :default => false
    t.integer  "door_number"
    t.date     "stop_date"
    t.datetime "start_date"
    t.boolean  "reminded",        :default => false
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  add_index "events", ["category_id"], :name => "index_events_on_category_id"

  create_table "events_tags", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "tag_id"
  end

  add_index "events_tags", ["event_id", "tag_id"], :name => "index_events_tags_on_event_id_and_tag_id", :unique => true

  create_table "events_users", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id", "user_id"], :name => "index_events_users_on_event_id_and_user_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.string   "surname"
    t.string   "crypted_password"
    t.boolean  "admin",             :default => false
    t.boolean  "moderator",         :default => false
    t.string   "persistence_token"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visibilities", :force => true do |t|
    t.boolean  "email"
    t.boolean  "name"
    t.boolean  "surname"
    t.boolean  "avatar_url"
    t.boolean  "events"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
