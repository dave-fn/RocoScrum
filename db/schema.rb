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

ActiveRecord::Schema.define(version: 2019_02_22_050429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "last_logged_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id", unique: true
  end

  create_table "backlog_items", force: :cascade do |t|
    t.string "title", null: false
    t.text "requirement"
    t.text "description"
    t.boolean "ready", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "timebox"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_statuses", force: :cascade do |t|
    t.bigint "team_id"
    t.string "context", limit: 5, null: false
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context"], name: "index_item_statuses_on_context"
    t.index ["team_id", "context", "title"], name: "index_item_statuses_on_team_id_and_context_and_title", unique: true
    t.index ["team_id"], name: "index_item_statuses_on_team_id"
  end

  create_table "product_backlog_items", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "backlog_item_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backlog_item_id", "product_id"], name: "index_product_backlog_items_on_backlog_item_id_and_product_id", unique: true
    t.index ["backlog_item_id"], name: "index_product_backlog_items_on_backlog_item_id"
    t.index ["product_id", "backlog_item_id"], name: "index_product_backlog_items_on_product_id_and_backlog_item_id", unique: true
    t.index ["product_id"], name: "index_product_backlog_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "owner_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_products_on_owner_id"
    t.index ["project_id"], name: "index_products_on_project_id"
  end

  create_table "project_sprints", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "sprint_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "sprint_id"], name: "index_project_sprints_on_project_id_and_sprint_id", unique: true
    t.index ["project_id"], name: "index_project_sprints_on_project_id"
    t.index ["sprint_id", "project_id"], name: "index_project_sprints_on_sprint_id_and_project_id", unique: true
    t.index ["sprint_id"], name: "index_project_sprints_on_sprint_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_projects_on_admin_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.integer "min_participants", default: 1, null: false
    t.integer "max_participants", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sbi_status_updates", force: :cascade do |t|
    t.bigint "sprint_backlog_item_id"
    t.bigint "item_status_id"
    t.bigint "developer_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_sbi_status_updates_on_creator_id"
    t.index ["developer_id"], name: "index_sbi_status_updates_on_developer_id"
    t.index ["item_status_id"], name: "index_sbi_status_updates_on_item_status_id"
    t.index ["sprint_backlog_item_id"], name: "index_sbi_status_updates_on_sprint_backlog_item_id"
  end

  create_table "sprint_backlog_items", force: :cascade do |t|
    t.bigint "sprint_id"
    t.bigint "backlog_item_id"
    t.bigint "team_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backlog_item_id", "sprint_id"], name: "index_sprint_backlog_items_on_backlog_item_id_and_sprint_id", unique: true
    t.index ["backlog_item_id"], name: "index_sprint_backlog_items_on_backlog_item_id"
    t.index ["sprint_id", "backlog_item_id"], name: "index_sprint_backlog_items_on_sprint_id_and_backlog_item_id", unique: true
    t.index ["sprint_id"], name: "index_sprint_backlog_items_on_sprint_id"
    t.index ["team_id"], name: "index_sprint_backlog_items_on_team_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "goal"
    t.integer "duration"
    t.datetime "started_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_team_memberships_on_role_id"
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_teams_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "last_logged_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "admins", "users"
  add_foreign_key "item_statuses", "teams"
  add_foreign_key "product_backlog_items", "backlog_items"
  add_foreign_key "product_backlog_items", "products"
  add_foreign_key "products", "projects"
  add_foreign_key "products", "users", column: "owner_id"
  add_foreign_key "project_sprints", "projects"
  add_foreign_key "project_sprints", "sprints"
  add_foreign_key "projects", "users", column: "admin_id"
  add_foreign_key "sbi_status_updates", "item_statuses"
  add_foreign_key "sbi_status_updates", "sprint_backlog_items"
  add_foreign_key "sbi_status_updates", "users", column: "creator_id"
  add_foreign_key "sbi_status_updates", "users", column: "developer_id"
  add_foreign_key "sprint_backlog_items", "backlog_items"
  add_foreign_key "sprint_backlog_items", "sprints"
  add_foreign_key "sprint_backlog_items", "teams"
  add_foreign_key "team_memberships", "roles"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "teams", "projects"
end
