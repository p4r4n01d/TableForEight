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

ActiveRecord::Schema.define(version: 20140320025742) do

  create_table "events", force: true do |t|
    t.datetime "date"
    t.datetime "cutoff_at"
    t.string   "link1"
    t.string   "name1"
    t.string   "link2"
    t.string   "name2"
    t.string   "link3"
    t.string   "name3"
    t.string   "link4"
    t.string   "name4"
    t.string   "link5"
    t.string   "name5"
    t.datetime "date1"
    t.datetime "date2"
    t.datetime "date3"
    t.string   "hash"
    t.string   "organiser_email"
    t.string   "organiser_name"
<<<<<<< HEAD
=======
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisers", force: true do |t|
    t.string   "name"
    t.string   "email"
>>>>>>> 2fac8ec54089bba5f383375e49effdf6dbed6b7f
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.string   "email"
    t.integer  "link1"
    t.integer  "link2"
    t.integer  "link3"
    t.integer  "link4"
    t.integer  "link5"
    t.integer  "date1"
    t.integer  "date2"
    t.integer  "date3"
    t.boolean  "confirmed"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["event_id"], name: "index_votes_on_event_id"

end
