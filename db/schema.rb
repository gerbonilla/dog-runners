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

ActiveRecord::Schema.define(version: 20170828100554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dogs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "description"
    t.string "photo"
    t.string "breed"
    t.decimal "weight"
    t.integer "age"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "parks", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "description"
    t.string "photo"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "title"
    t.text "content"
    t.bigint "run_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_reviews_on_run_id"
  end

  create_table "runs", force: :cascade do |t|
    t.bigint "dog_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "appointment"
    t.integer "duration"
    t.decimal "price"
    t.string "note"
    t.bigint "park_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_runs_on_dog_id"
    t.index ["park_id"], name: "index_runs_on_park_id"
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.string "photo"
    t.integer "role"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dogs", "users"
  add_foreign_key "reviews", "runs"
  add_foreign_key "runs", "dogs"
  add_foreign_key "runs", "parks"
  add_foreign_key "runs", "users"
end
