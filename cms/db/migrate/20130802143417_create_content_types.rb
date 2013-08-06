class CreateContentTypes < ActiveRecord::Migration
  def change
    create_table :content_types do |t|
      t.integer :project_id
      t.integer :ref_id
      t.string :name
      t.string :intern
      t.integer :editor
      t.text :meta

      t.timestamps
    end
    
    add_index :content_types, :project_id
    add_index :content_types, :ref_id
    add_index :content_types, :editor
  end
end
