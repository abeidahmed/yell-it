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

ActiveRecord::Schema.define(version: 2021_01_05_140249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "join_date"
    t.string "role", default: "editor", null: false
    t.uuid "project_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["join_date", "role"], name: "index_memberships_on_join_date_and_role"
    t.index ["project_id"], name: "index_memberships_on_project_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "subdomain", default: "", null: false
    t.string "plan", default: "free", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_customer_id", default: ""
    t.string "stripe_subscription_id", default: ""
    t.string "card_brand", default: ""
    t.integer "card_exp_month"
    t.integer "card_exp_year"
    t.string "card_last4", default: ""
    t.index ["plan"], name: "index_projects_on_plan"
    t.index ["stripe_customer_id", "stripe_subscription_id"], name: "index_projects_on_stripe_customer_id_and_stripe_subscription_id"
    t.index ["subdomain"], name: "index_projects_on_subdomain", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name", default: ""
    t.string "email_address", default: "", null: false
    t.string "password_digest"
    t.string "auth_token", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "memberships", "projects"
  add_foreign_key "memberships", "users"
end
