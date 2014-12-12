class AddIndices < ActiveRecord::Migration
  def change
    add_index :branches, :hidden
    add_index :branches, :unattached

    add_index :constant_relations, :constant_id
    add_index :constant_relations, :configurable_id
    add_index :constant_relations, :configurable_type

    add_index :constants, :category
    add_index :constants, :art
    add_index :constants, :sys
    add_index :constants, :project_id

    add_index :content_relation_types, :intern
    add_index :content_relation_types, :content_type_id
    add_index :content_relation_types, :relative_type_id
    add_index :content_relation_types, :relation_type

    add_index :content_relations, :content_relation_type_id
    add_index :content_relations, :content_id
    add_index :content_relations, :relative_id
    add_index :content_relations, :position

    add_index :content_types, :direct_edit
    add_index :content_types, :intern

    add_index :content_types_to_branches, :branch_id
    add_index :content_types_to_branches, :content_type_id

    add_index :contents, :old_id
    add_index :contents, :ref_id
    add_index :contents, :project_id
    add_index :contents, :content_type_id
    add_index :contents, :alpha_datum
    add_index :contents, :omega_datum
    add_index :contents, :user_id
    add_index :contents, :status

    add_index :documentables, :project_id
    add_index :documentables, :document_id
    add_index :documentables, :documentable_type
    add_index :documentables, :documentable_id
    add_index :documentables, :doctype
    add_index :documentables, :position

    add_index :documents, :project_id

    add_index :hosts, :project_id
    add_index :hosts, :host
    add_index :hosts, :protocol
    add_index :hosts, :primary

    add_index :permissions, :user_id
    add_index :permissions, :project_id
    add_index :permissions, :action
    add_index :permissions, :subject_class
    add_index :permissions, :subject_id
    add_index :permissions, :inverse

    add_index :projects, :intern

    add_index :templatables, :project_id
    add_index :templatables, :template_id
    add_index :templatables, :templatable_type
    add_index :templatables, :templatable_id

    add_index :templates, :project_id
    add_index :templates, :action

    add_index :workspaceables, :workspace_id
    add_index :workspaceables, :workspaceable_type
    add_index :workspaceables, :workspaceable_id

    add_index :workspaces, :project_id
    add_index :workspaces, :intern
    add_index :workspaces, :constellation

  end
end
