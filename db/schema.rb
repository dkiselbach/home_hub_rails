# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_20_133007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "air_quality_logs", force: :cascade do |t|
    t.datetime "reading_time", null: false
    t.integer "ten_min_average"
    t.integer "current_average", null: false
    t.integer "thirty_min_average"
    t.integer "hour_average"
    t.integer "day_average"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "home_id", null: false
    t.index ["home_id"], name: "index_air_quality_logs_on_home_id"
  end

  create_table "home_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "home_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["home_id"], name: "index_home_users_on_home_id"
    t.index ["user_id"], name: "index_home_users_on_user_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string "name"
    t.float "nw_lat"
    t.float "nw_long"
    t.float "se_lat"
    t.float "se_long"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partner_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "home_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ip_address", null: false
    t.index ["home_id"], name: "index_partner_tokens_on_home_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "air_quality_logs", "homes"
  add_foreign_key "home_users", "homes"
  add_foreign_key "home_users", "users"
  add_foreign_key "partner_tokens", "homes"
end
