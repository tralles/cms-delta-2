class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :ref_id
      t.integer :project_id
      t.string :name
      t.text :description
      t.integer :status

      t.timestamps
    end
    
    add_index :projects, :ref_id
    add_index :projects, :project_id
  end
end
