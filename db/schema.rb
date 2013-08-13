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

ActiveRecord::Schema.define(:version => 20120904045107) do

  create_table "articles", :force => true do |t|
    t.string   "link"
    t.string   "title"
    t.string   "description"
    t.integer  "player_id"
    t.datetime "published"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "team"
    t.string   "injury_status"
    t.string   "bye_week"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "yahoo_key"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "yahoo_id"
    t.integer  "ffn_id"
    t.string   "rotoworld_key"
    t.integer  "rotoworld_id"
    t.string   "lookup_key"
    t.boolean  "active"
    t.float    "points",        :default => 0.0
  end

  create_table "projections", :force => true do |t|
    t.integer  "player_id"
    t.integer  "week"
    t.float    "standard"
    t.float    "standard_low"
    t.float    "standard_high"
    t.float    "ppr"
    t.float    "ppr_low"
    t.float    "ppr_high"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teams", :force => true do |t|
    t.integer  "yahoo_id"
    t.string   "yahoo_key"
    t.integer  "yahoo_owner_id"
    t.string   "yahoo_owner_name"
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
