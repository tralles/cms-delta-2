class CreateContentToBranches < ActiveRecord::Migration
  def change
    create_table :content_to_branches do |t|
      t.integer :branch_id
      t.integer :content_id
      t.integer :position

      t.timestamps
    end
    
    add_index :content_to_branches, :branch_id
    add_index :content_to_branches, :content_id
    add_index :content_to_branches, :position
    
  end
end
