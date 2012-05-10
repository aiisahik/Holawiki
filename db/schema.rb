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

ActiveRecord::Schema.define(:version => 20120429180533) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "node_id"
    t.string   "comment_text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "comments", ["node_id"], :name => "index_comments_on_node_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "nodes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "node_type"
    t.integer  "speaker_id"
    t.string   "node_text"
    t.integer  "previous_node_id"
    t.integer  "scenario_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "nodes", ["previous_node_id"], :name => "index_nodes_on_previous_node_id"
  add_index "nodes", ["scenario_id"], :name => "index_nodes_on_scenario_id"
  add_index "nodes", ["speaker_id"], :name => "index_nodes_on_speaker_id"
  add_index "nodes", ["user_id"], :name => "index_nodes_on_user_id"

  create_table "scenarios", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "speakers", :force => true do |t|
    t.integer  "scenario_id"
    t.string   "name"
    t.integer  "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "speakers", ["scenario_id"], :name => "index_speakers_on_scenario_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.date     "dob"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "vote"
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["node_id"], :name => "index_votes_on_node_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
