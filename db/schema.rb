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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140821023300) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.integer  "team_count"
    t.integer  "round_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
  end

  create_table "kauravas", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.integer  "points"
    t.integer  "pstart"
    t.integer  "pcurrent"
    t.boolean  "defeated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pandavas", force: true do |t|
    t.integer  "team_id"
    t.string   "name"
    t.integer  "attack"
    t.boolean  "used"
    t.integer  "kaurava_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "victory"
  end

  create_table "rounds", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete",   default: false
  end

  create_table "teams", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

end
