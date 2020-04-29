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

ActiveRecord::Schema.define(version: 2020_04_29_184126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "app_templates", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_domains", force: :cascade do |t|
    t.string "url"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_domains_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "auth_token"
    t.string "subdomain"
  end

  create_table "devworkflow_check_list_items", force: :cascade do |t|
    t.bigint "devworkflow_project_line_item_id"
    t.string "title"
    t.boolean "completed", default: false
    t.bigint "devworkflow_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "dw_cli_client"
    t.index ["devworkflow_project_line_item_id"], name: "dw_pli_cli"
    t.index ["devworkflow_user_id"], name: "dw_u_cli"
  end

  create_table "devworkflow_project_line_items", force: :cascade do |t|
    t.bigint "devworkflow_project_id"
    t.string "title"
    t.text "description"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "dw_pli_client"
    t.index ["devworkflow_project_id"], name: "index_devworkflow_project_line_items_on_devworkflow_project_id"
  end

  create_table "devworkflow_projects", force: :cascade do |t|
    t.string "title"
    t.string "main_objective"
    t.bigint "devworkflow_user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "dw_project_client"
    t.index ["devworkflow_user_id"], name: "index_devworkflow_projects_on_devworkflow_user_id"
  end

  create_table "devworkflow_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "dw_user_client"
  end

  create_table "endpoints", force: :cascade do |t|
    t.bigint "project_id"
    t.string "title"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "http_verb"
    t.index ["project_id"], name: "index_endpoints_on_project_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "memipedia_posts", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "memipedia_user_id"
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_memipedia_posts_on_client_id"
    t.index ["memipedia_user_id"], name: "index_memipedia_posts_on_memipedia_user_id"
  end

  create_table "memipedia_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.bigint "client_id"
    t.bigint "app_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_template_id"], name: "index_memipedia_users_on_app_template_id"
    t.index ["client_id"], name: "index_memipedia_users_on_client_id"
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

  create_table "portfolio_blogs", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "blog_status", default: 0
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_portfolio_blogs_on_client_id"
  end

  create_table "portfolio_items", force: :cascade do |t|
    t.bigint "client_id"
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "position"
    t.index ["client_id"], name: "index_portfolio_items_on_client_id"
  end

  create_table "portfolio_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_tables", force: :cascade do |t|
    t.bigint "project_id"
    t.string "formatted_name"
    t.string "table_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_tables_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
    t.string "logo"
    t.text "slug"
    t.text "white_logo"
    t.string "route_namespace"
  end

  add_foreign_key "client_domains", "clients"
  add_foreign_key "devworkflow_check_list_items", "clients"
  add_foreign_key "devworkflow_check_list_items", "devworkflow_project_line_items"
  add_foreign_key "devworkflow_check_list_items", "devworkflow_users"
  add_foreign_key "devworkflow_project_line_items", "clients"
  add_foreign_key "devworkflow_project_line_items", "devworkflow_projects"
  add_foreign_key "devworkflow_projects", "clients"
  add_foreign_key "devworkflow_projects", "devworkflow_users"
  add_foreign_key "devworkflow_users", "clients"
  add_foreign_key "endpoints", "projects"
  add_foreign_key "memipedia_posts", "clients"
  add_foreign_key "memipedia_posts", "memipedia_users"
  add_foreign_key "memipedia_users", "app_templates"
  add_foreign_key "memipedia_users", "clients"
  add_foreign_key "portfolio_app_users", "app_templates"
  add_foreign_key "portfolio_app_users", "clients"
  add_foreign_key "portfolio_blogs", "clients"
  add_foreign_key "portfolio_items", "clients"
  add_foreign_key "project_tables", "projects"
end
