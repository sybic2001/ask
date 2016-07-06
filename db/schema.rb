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

ActiveRecord::Schema.define(version: 20160706094018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.string   "photo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "competencies", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "parent_competency_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer  "user_competency_id"
    t.string   "company"
    t.string   "project"
    t.string   "description"
    t.integer  "year"
    t.integer  "duration"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "experiences", ["user_competency_id"], name: "index_experiences_on_user_competency_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_competency_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "favorites", ["user_competency_id"], name: "index_favorites_on_user_competency_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.date     "date"
    t.integer  "duration"
    t.string   "status"
    t.integer  "user_competency_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "helper_id"
    t.integer  "helpee_id"
  end

  add_index "meetings", ["user_competency_id"], name: "index_meetings_on_user_competency_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "community_id"
    t.integer  "user_id"
    t.string   "status",                default: "pending approval"
    t.integer  "community_time_credit", default: 2
    t.boolean  "community_manager",     default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "memberships", ["community_id"], name: "index_memberships_on_community_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "meeting_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "sender_id"
    t.integer  "receiver_id"
  end

  add_index "messages", ["meeting_id"], name: "index_messages_on_meeting_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total_time_credit"
    t.string   "address"
    t.string   "city"
    t.string   "phone_number"
    t.string   "photo"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "user_rating"
    t.string   "user_comment"
    t.integer  "competency_rating"
    t.string   "competency_comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "reviews", ["meeting_id"], name: "index_reviews_on_meeting_id", using: :btree

  create_table "user_competencies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "competency_id"
    t.integer  "level"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "description"
  end

  add_index "user_competencies", ["competency_id"], name: "index_user_competencies_on_competency_id", using: :btree
  add_index "user_competencies", ["user_id"], name: "index_user_competencies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "experiences", "user_competencies"
  add_foreign_key "favorites", "user_competencies"
  add_foreign_key "favorites", "users"
  add_foreign_key "meetings", "user_competencies"
  add_foreign_key "memberships", "communities"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "meetings"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "meetings"
  add_foreign_key "user_competencies", "competencies"
  add_foreign_key "user_competencies", "users"
end
