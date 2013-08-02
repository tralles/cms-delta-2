class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.integer :ref_id
      t.integer :project_id
      t.string :name
      t.integer :position
      t.boolean :hidden
      t.boolean :unattached
      t.string :ancestry

      t.timestamps
    end
    
    add_index :branches, :ancestry
    add_index :branches, :ref_id
    add_index :branches, :project_id
    add_index :branches, :position

  end
end
