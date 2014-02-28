class CreateWorkspaceables < ActiveRecord::Migration
  def change
    create_table :workspaceables do |t|
      t.integer :workspace_id
      t.string :workspaceable_type
      t.integer :workspaceable_id

      t.timestamps
    end
  end
end
