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

ActiveRecord::Schema.define(version: 20130831174704) do

  create_table "branch_routes", force: true do |t|
    t.integer  "branch_id"
    t.string   "language"
    t.string   "name"
    t.string   "route"
    t.string   "jump"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branch_routes", ["branch_id"], name: "index_branch_routes_on_branch_id", using: :btree
  add_index "branch_routes", ["language"], name: "index_branch_routes_on_language", using: :btree

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

  create_table "constant_relations", force: true do |t|
    t.integer  "constant_id"
    t.integer  "configurable_id"
    t.string   "configurable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constants", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.text     "value"
    t.string   "art"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sys"
  end

  create_table "content_element_types", force: true do |t|
    t.integer  "content_type_id"
    t.integer  "ref_id"
    t.string   "name"
    t.string   "intern"
    t.string   "field_type"
    t.integer  "position"
    t.boolean  "mandatory"
    t.boolean  "badge"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inline_documents"
  end

  add_index "content_element_types", ["badge"], name: "index_content_element_types_on_badge", using: :btree
  add_index "content_element_types", ["content_type_id"], name: "index_content_element_types_on_content_type_id", using: :btree
  add_index "content_element_types", ["field_type"], name: "index_content_element_types_on_field_type", using: :btree
  add_index "content_element_types", ["mandatory"], name: "index_content_element_types_on_mandatory", using: :btree
  add_index "content_element_types", ["position"], name: "index_content_element_types_on_position", using: :btree
  add_index "content_element_types", ["ref_id"], name: "index_content_element_types_on_ref_id", using: :btree

  create_table "content_elements", force: true do |t|
    t.integer  "content_id"
    t.integer  "content_element_type_id"
    t.string   "language"
    t.text     "value"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_elements", ["content_element_type_id"], name: "index_content_elements_on_content_element_type_id", using: :btree
  add_index "content_elements", ["content_id"], name: "index_content_elements_on_content_id", using: :btree
  add_index "content_elements", ["language"], name: "index_content_elements_on_language", using: :btree

  create_table "content_relation_types", force: true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.string   "intern"
    t.integer  "content_type_id"
    t.integer  "relative_type_id"
    t.string   "relation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "content_relations", force: true do |t|
    t.integer  "content_relation_type_id"
    t.integer  "content_id"
    t.integer  "relative_id"
    t.integer  "position"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_to_branches", force: true do |t|
    t.integer  "branch_id"
    t.integer  "content_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_to_branches", ["branch_id"], name: "index_content_to_branches_on_branch_id", using: :btree
  add_index "content_to_branches", ["content_id"], name: "index_content_to_branches_on_content_id", using: :btree
  add_index "content_to_branches", ["position"], name: "index_content_to_branches_on_position", using: :btree

  create_table "content_types", force: true do |t|
    t.integer  "project_id"
    t.integer  "ref_id"
    t.string   "name"
    t.string   "intern"
    t.integer  "editor"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "direct_edit"
  end

  add_index "content_types", ["editor"], name: "index_content_types_on_editor", using: :btree
  add_index "content_types", ["project_id"], name: "index_content_types_on_project_id", using: :btree
  add_index "content_types", ["ref_id"], name: "index_content_types_on_ref_id", using: :btree

  create_table "content_types_to_branches", force: true do |t|
    t.integer  "branch_id"
    t.integer  "content_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.integer  "old_id"
    t.integer  "ref_id"
    t.integer  "project_id"
    t.integer  "content_type_id"
    t.datetime "alpha_datum"
    t.datetime "omega_datum"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentables", force: true do |t|
    t.integer  "project_id"
    t.integer  "document_id"
    t.string   "documentable_type"
    t.integer  "documentable_id"
    t.integer  "doctype"
    t.string   "title"
    t.text     "info"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "project_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", force: true do |t|
    t.integer  "project_id"
    t.string   "protocol",   default: "http://"
    t.string   "host"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "intern"
    t.string   "analytics"
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

  create_table "users_to_projects", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_to_projects", ["project_id"], name: "index_users_to_projects_on_project_id", using: :btree
  add_index "users_to_projects", ["user_id"], name: "index_users_to_projects_on_user_id", using: :btree

end
