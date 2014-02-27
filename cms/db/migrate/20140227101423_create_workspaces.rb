class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|
      t.integer :project_id
      t.string :intern
      t.string :name
      t.string :constellation 

      t.timestamps
    end
  end
end
