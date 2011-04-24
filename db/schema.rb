# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110414085905) do

  create_table "elections", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "mode"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "one_vote"
    t.string   "three_vote"
    t.string   "rank_vote"
    t.string   "free_choice_vote"
    t.string   "good_bad_vote"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "show_key"
  end

  create_table "free_choice_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "election_id"
    t.integer  "selection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "good_bad_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "election_id"
    t.integer  "selection_id"
    t.string   "choice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "one_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "election_id"
    t.integer  "selection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rank_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "election_id"
    t.integer  "selection_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selections", :force => true do |t|
    t.integer  "user_id"
    t.integer  "election_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "three_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "election_id"
    t.integer  "selection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login_id"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "display_name"
    t.string   "level"
    t.string   "twitter_id"
    t.string   "mail_address"
    t.string   "gender"
    t.string   "nationality"
    t.string   "generation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
