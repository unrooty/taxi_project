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

ActiveRecord::Schema.define(version: 20180205120717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliates", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", id: :serial, force: :cascade do |t|
    t.string "brand"
    t.string "car_model"
    t.string "reg_number"
    t.string "color"
    t.string "style"
    t.integer "affiliate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "car_status", default: 0, null: false
    t.index ["affiliate_id"], name: "index_cars_on_affiliate_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feedbacks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.decimal "distance"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.decimal "payed_amount", default: "0.0", null: false
    t.integer "invoice_status", default: 0, null: false
    t.decimal "indebtedness", default: "0.0", null: false
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "end_point"
    t.string "client_name"
    t.string "client_phone"
    t.integer "user_id"
    t.integer "tax_id"
    t.string "start_point"
    t.integer "order_status", default: 0, null: false
  end

  create_table "taxes", id: :serial, force: :cascade do |t|
    t.decimal "cost_per_km"
    t.decimal "basic_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "deleted", default: false, null: false
    t.boolean "by_default", default: false, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
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
    t.string "phone"
    t.integer "affiliate_id"
    t.integer "role", default: 5, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "language", default: 0, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "affiliates"
  add_foreign_key "orders", "cars"
  add_foreign_key "orders", "taxes"
end
