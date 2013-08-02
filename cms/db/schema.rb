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

ActiveRecord::Schema.define(version: 20130802143846) do

  create_table "branch_routes", force: true do |t|
    t.integer  "branch_id"
    t.integer  "language_id"
    t.string   "name"
    t.string   "route"
    t.string   "jump"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branch_routes", ["branch_id"], name: "index_branch_routes_on_branch_id", using: :btree
  add_index "branch_routes", ["language_id"], name: "index_branch_routes_on_language_id", using: :btree

  create_table "branches", force: true do |t|
    t.integer  "ref_id"
    t.integer  "project_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "hidden"
    t.boolean  "unattached"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["ancestry"], name: "index_branches_on_ancestry", using: :btree
  add_index "branches", ["position"], name: "index_branches_on_position", using: :btree
  add_index "branches", ["project_id"], name: "index_branches_on_project_id", using: :btree
  add_index "branches", ["ref_id"], name: "index_branches_on_ref_id", using: :btree

  create_table "content_element_types", force: true do |t|
    t.integer  "content_type_id"
    t.integer  "ref_id"
    t.string   "name"
    t.string   "intern"
    t.integer  "field_type"
    t.integer  "position"
    t.boolean  "mandatory"
    t.boolean  "badge"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_element_types", ["badge"], name: "index_content_element_types_on_badge", using: :btree
  add_index "content_element_types", ["content_type_id"], name: "index_content_element_types_on_content_type_id", using: :btree
  add_index "content_element_types", ["field_type"], name: "index_content_element_types_on_field_type", using: :btree
  add_index "content_element_types", ["mandatory"], name: "index_content_element_types_on_mandatory", using: :btree
  add_index "content_element_types", ["position"], name: "index_content_element_types_on_position", using: :btree
  add_index "content_element_types", ["ref_id"], name: "index_content_element_types_on_ref_id", using: :btree

  create_table "content_types", force: true do |t|
    t.integer  "project_id"
    t.integer  "ref_id"
    t.string   "name"
    t.string   "intern"
    t.integer  "editor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_types", ["editor"], name: "index_content_types_on_editor", using: :btree
  add_index "content_types", ["project_id"], name: "index_content_types_on_project_id", using: :btree
  add_index "content_types", ["ref_id"], name: "index_content_types_on_ref_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "sign"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages_to_projects", id: false, force: true do |t|
    t.integer  "language_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages_to_projects", ["language_id"], name: "index_languages_to_projects_on_language_id", using: :btree
  add_index "languages_to_projects", ["project_id"], name: "index_languages_to_projects_on_project_id", using: :btree

  create_table "permissions", force: true do |t|
    t.string   "name"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.string   "action"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "ref_id"
    t.integer  "project_id"
    t.string   "name"
    t.text     "description"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["project_id"], name: "index_projects_on_project_id", using: :btree
  add_index "projects", ["ref_id"], name: "index_projects_on_ref_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.boolean  "admin"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_to_permissions", force: true do |t|
    t.integer  "permission_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_to_permissions", ["permission_id"], name: "index_users_to_permissions_on_permission_id", using: :btree
  add_index "users_to_permissions", ["project_id"], name: "index_users_to_permissions_on_project_id", using: :btree
  add_index "users_to_permissions", ["user_id"], name: "index_users_to_permissions_on_user_id", using: :btree

  create_table "users_to_projects", id: false, force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_to_projects", ["project_id"], name: "index_users_to_projects_on_project_id", using: :btree
  add_index "users_to_projects", ["user_id"], name: "index_users_to_projects_on_user_id", using: :btree

end
