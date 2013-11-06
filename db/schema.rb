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

ActiveRecord::Schema.define(version: 20131106024549) do

  create_table "coops", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "bfast_time"
    t.time     "lunch_time"
    t.time     "dinner_time"
    t.string   "monday",      default: ""
    t.string   "tuesday",     default: ""
    t.string   "wednesday",   default: ""
    t.string   "thursday",    default: ""
    t.string   "friday",      default: ""
    t.string   "saturday",    default: ""
    t.string   "sunday",      default: ""
  end

  create_table "meals", force: true do |t|
    t.string   "meal_type"
    t.boolean  "isSpecial"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "meal_info"
    t.string   "discussion_info"
    t.integer  "coop_id"
    t.boolean  "cancelled"
  end

  add_index "meals", ["coop_id"], name: "index_meals_on_coop_id"

  create_table "swap_requests", force: true do |t|
    t.boolean  "headcook_required"
    t.text     "message",           limit: 255
    t.datetime "date"
    t.boolean  "isResolved?"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "swap_requests", ["user_id"], name: "index_swap_requests_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coop_id"
  end

  add_index "users", ["coop_id"], name: "index_users_on_coop_id"

end
