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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170730154244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.integer  "game_id"
    t.integer  "competitor_count"
    t.integer  "competitors_per_heat"
    t.integer  "winners_per_heat"
    t.integer  "current_round",        default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heats", force: :cascade do |t|
    t.integer  "competition_id"
    t.integer  "index"
    t.integer  "winner_count"
    t.integer  "player_count"
    t.integer  "round_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "heat_id"
    t.integer  "user_id"
    t.integer  "score"
    t.string   "gamertag"
    t.integer  "competition_id"
    t.integer  "is_winner",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",         null: false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
