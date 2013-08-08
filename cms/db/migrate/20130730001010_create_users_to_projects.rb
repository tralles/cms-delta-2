class CreateUsersToProjects < ActiveRecord::Migration
  def change
    create_table :users_to_projects do |t|

      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
    
    add_index :users_to_projects, :project_id
    add_index :users_to_projects, :user_id
  end
end
