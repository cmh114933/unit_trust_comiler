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

ActiveRecord::Schema.define(version: 20160916065130) do

  create_table "unit_trusts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.float    "original_price"
    t.float    "price",              default: 0.0
    t.float    "original_num_units"
    t.float    "num_units",          default: 0.0
    t.string   "url"
    t.string   "start_month"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "unit_trusts", ["user_id"], name: "index_unit_trusts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "ut_histories", force: :cascade do |t|
    t.integer  "unit_trust_id"
    t.string   "month"
    t.float    "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ut_histories", ["unit_trust_id"], name: "index_ut_histories_on_unit_trust_id"

end
