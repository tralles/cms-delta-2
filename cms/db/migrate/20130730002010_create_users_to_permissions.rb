class CreateUsersToPermissions < ActiveRecord::Migration
  def change
    create_table :users_to_permissions do |t|
      t.integer :permission_id
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
    
    add_index :users_to_permissions, :permission_id
    add_index :users_to_permissions, :user_id
    add_index :users_to_permissions, :project_id
    
  end
end
