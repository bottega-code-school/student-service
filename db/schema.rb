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

ActiveRecord::Schema.define(version: 2018_09_16_065017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_templates", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "auth_token"
    t.string "subdomain"
  end

  create_table "portfolio_app_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_template_id"
    t.bigint "client_id"
    t.index ["app_template_id"], name: "index_portfolio_app_users_on_app_template_id"
    t.index ["client_id"], name: "index_portfolio_app_users_on_client_id"
  end

  create_table "portfolio_items", force: :cascade do |t|
    t.bigint "client_id"
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_portfolio_items_on_client_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
    t.string "logo"
  end

  add_foreign_key "portfolio_app_users", "app_templates"
  add_foreign_key "portfolio_app_users", "clients"
  add_foreign_key "portfolio_items", "clients"
end
