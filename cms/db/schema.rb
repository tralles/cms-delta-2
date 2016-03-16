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

ActiveRecord::Schema.define(version: 20160308190359) do

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
  add_index "branches", ["hidden"], name: "index_branches_on_hidden", using: :btree
  add_index "branches", ["position"], name: "index_branches_on_position", using: :btree
  add_index "branches", ["project_id"], name: "index_branches_on_project_id", using: :btree
  add_index "branches", ["ref_id"], name: "index_branches_on_ref_id", using: :btree
  add_index "branches", ["unattached"], name: "index_branches_on_unattached", using: :btree

  create_table "constant_relations", force: true do |t|
    t.integer  "constant_id"
    t.integer  "configurable_id"
    t.string   "configurable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "constant_relations", ["configurable_id"], name: "index_constant_relations_on_configurable_id", using: :btree
  add_index "constant_relations", ["configurable_type"], name: "index_constant_relations_on_configurable_type", using: :btree
  add_index "constant_relations", ["constant_id"], name: "index_constant_relations_on_constant_id", using: :btree

  create_table "constants", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.text     "value"
    t.string   "art"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sys"
    t.integer  "project_id"
  end

  add_index "constants", ["art"], name: "index_constants_on_art", using: :btree
  add_index "constants", ["category"], name: "index_constants_on_category", using: :btree
  add_index "constants", ["project_id"], name: "index_constants_on_project_id", using: :btree
  add_index "constants", ["sys"], name: "index_constants_on_sys", using: :btree

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
    t.text     "value",                   limit: 16777215
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
    t.integer  "binder_type_id"
  end

  add_index "content_relation_types", ["binder_type_id"], name: "index_content_relation_types_on_binder_type_id", using: :btree
  add_index "content_relation_types", ["content_type_id"], name: "index_content_relation_types_on_content_type_id", using: :btree
  add_index "content_relation_types", ["intern"], name: "index_content_relation_types_on_intern", using: :btree
  add_index "content_relation_types", ["relation_type"], name: "index_content_relation_types_on_relation_type", using: :btree
  add_index "content_relation_types", ["relative_type_id"], name: "index_content_relation_types_on_relative_type_id", using: :btree

  create_table "content_relations", force: true do |t|
    t.integer  "content_relation_type_id"
    t.integer  "content_id"
    t.integer  "relative_id"
    t.integer  "position"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "binder_id"
  end

  add_index "content_relations", ["binder_id"], name: "index_content_relations_on_binder_id", using: :btree
  add_index "content_relations", ["content_id"], name: "index_content_relations_on_content_id", using: :btree
  add_index "content_relations", ["content_relation_type_id"], name: "index_content_relations_on_content_relation_type_id", using: :btree
  add_index "content_relations", ["position"], name: "index_content_relations_on_position", using: :btree
  add_index "content_relations", ["relative_id"], name: "index_content_relations_on_relative_id", using: :btree

  create_table "content_to_branches", force: true do |t|
    t.integer  "branch_id"
    t.integer  "content_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "link"
    t.string   "caption"
  end

  add_index "content_to_branches", ["branch_id"], name: "index_content_to_branches_on_branch_id", using: :btree
  add_index "content_to_branches", ["content_id"], name: "index_content_to_branches_on_content_id", using: :btree
  add_index "content_to_branches", ["link"], name: "index_content_to_branches_on_link", using: :btree
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

  add_index "content_types", ["direct_edit"], name: "index_content_types_on_direct_edit", using: :btree
  add_index "content_types", ["editor"], name: "index_content_types_on_editor", using: :btree
  add_index "content_types", ["intern"], name: "index_content_types_on_intern", using: :btree
  add_index "content_types", ["project_id"], name: "index_content_types_on_project_id", using: :btree
  add_index "content_types", ["ref_id"], name: "index_content_types_on_ref_id", using: :btree

  create_table "content_types_to_branches", force: true do |t|
    t.integer  "branch_id"
    t.integer  "content_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_types_to_branches", ["branch_id"], name: "index_content_types_to_branches_on_branch_id", using: :btree
  add_index "content_types_to_branches", ["content_type_id"], name: "index_content_types_to_branches_on_content_type_id", using: :btree

  create_table "content_types_to_workspaces", force: true do |t|
    t.integer  "content_type_id"
    t.integer  "workspace_id"
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
    t.text     "filenames"
    t.boolean  "hidden",          default: false
  end

  add_index "contents", ["alpha_datum"], name: "index_contents_on_alpha_datum", using: :btree
  add_index "contents", ["content_type_id"], name: "index_contents_on_content_type_id", using: :btree
  add_index "contents", ["old_id"], name: "index_contents_on_old_id", using: :btree
  add_index "contents", ["omega_datum"], name: "index_contents_on_omega_datum", using: :btree
  add_index "contents", ["project_id"], name: "index_contents_on_project_id", using: :btree
  add_index "contents", ["ref_id"], name: "index_contents_on_ref_id", using: :btree
  add_index "contents", ["status"], name: "index_contents_on_status", using: :btree
  add_index "contents", ["user_id"], name: "index_contents_on_user_id", using: :btree

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

  add_index "documentables", ["doctype"], name: "index_documentables_on_doctype", using: :btree
  add_index "documentables", ["document_id"], name: "index_documentables_on_document_id", using: :btree
  add_index "documentables", ["documentable_id"], name: "index_documentables_on_documentable_id", using: :btree
  add_index "documentables", ["documentable_type"], name: "index_documentables_on_documentable_type", using: :btree
  add_index "documentables", ["position"], name: "index_documentables_on_position", using: :btree
  add_index "documentables", ["project_id"], name: "index_documentables_on_project_id", using: :btree

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
    t.integer  "doctype"
  end

  add_index "documents", ["project_id"], name: "index_documents_on_project_id", using: :btree

  create_table "hosts", force: true do |t|
    t.integer  "project_id"
    t.string   "protocol",   default: "http://"
    t.string   "host"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hosts", ["host"], name: "index_hosts_on_host", using: :btree
  add_index "hosts", ["primary"], name: "index_hosts_on_primary", using: :btree
  add_index "hosts", ["project_id"], name: "index_hosts_on_project_id", using: :btree
  add_index "hosts", ["protocol"], name: "index_hosts_on_protocol", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "action"
    t.string   "subject_class"
    t.string   "subject_id"
    t.boolean  "inverse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["action"], name: "index_permissions_on_action", using: :btree
  add_index "permissions", ["inverse"], name: "index_permissions_on_inverse", using: :btree
  add_index "permissions", ["project_id"], name: "index_permissions_on_project_id", using: :btree
  add_index "permissions", ["subject_class"], name: "index_permissions_on_subject_class", using: :btree
  add_index "permissions", ["subject_id"], name: "index_permissions_on_subject_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

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
    t.text     "css"
    t.datetime "cache_version"
  end

  add_index "projects", ["intern"], name: "index_projects_on_intern", using: :btree
  add_index "projects", ["project_id"], name: "index_projects_on_project_id", using: :btree
  add_index "projects", ["ref_id"], name: "index_projects_on_ref_id", using: :btree

  create_table "templatables", force: true do |t|
    t.integer  "project_id"
    t.integer  "template_id"
    t.string   "templatable_type"
    t.integer  "templatable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "templatables", ["project_id"], name: "index_templatables_on_project_id", using: :btree
  add_index "templatables", ["templatable_id"], name: "index_templatables_on_templatable_id", using: :btree
  add_index "templatables", ["templatable_type"], name: "index_templatables_on_templatable_type", using: :btree
  add_index "templatables", ["template_id"], name: "index_templatables_on_template_id", using: :btree

  create_table "templates", force: true do |t|
    t.integer  "project_id"
    t.string   "action"
    t.string   "title"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "templates", ["action"], name: "index_templates_on_action", using: :btree
  add_index "templates", ["project_id"], name: "index_templates_on_project_id", using: :btree

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

  create_table "users_to_projects", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_to_projects", ["project_id"], name: "index_users_to_projects_on_project_id", using: :btree
  add_index "users_to_projects", ["user_id"], name: "index_users_to_projects_on_user_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "workspaceables", force: true do |t|
    t.integer  "workspace_id"
    t.string   "workspaceable_type"
    t.integer  "workspaceable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workspaceables", ["workspace_id"], name: "index_workspaceables_on_workspace_id", using: :btree
  add_index "workspaceables", ["workspaceable_id"], name: "index_workspaceables_on_workspaceable_id", using: :btree
  add_index "workspaceables", ["workspaceable_type"], name: "index_workspaceables_on_workspaceable_type", using: :btree

  create_table "workspaces", force: true do |t|
    t.integer  "project_id"
    t.string   "intern"
    t.string   "name"
    t.string   "constellation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workspaces", ["constellation"], name: "index_workspaces_on_constellation", using: :btree
  add_index "workspaces", ["intern"], name: "index_workspaces_on_intern", using: :btree
  add_index "workspaces", ["project_id"], name: "index_workspaces_on_project_id", using: :btree

end
