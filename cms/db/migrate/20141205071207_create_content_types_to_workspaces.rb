class CreateContentTypesToWorkspaces < ActiveRecord::Migration
  def change
    create_table :content_types_to_workspaces do |t|
      t.integer :content_type_id
      t.integer :workspace_id

      t.timestamps
    end
  end
end
