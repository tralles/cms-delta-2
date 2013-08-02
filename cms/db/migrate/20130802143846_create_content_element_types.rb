class CreateContentElementTypes < ActiveRecord::Migration
  def change
    create_table :content_element_types do |t|
      t.integer :content_type_id
      t.integer :ref_id
      t.string :name
      t.string :intern
      t.integer :field_type
      t.integer :position
      t.boolean :mandatory
      t.boolean :badge
      t.text :meta

      t.timestamps
    end
    
    add_index :content_element_types, :content_type_id
    add_index :content_element_types, :ref_id
    add_index :content_element_types, :field_type
    add_index :content_element_types, :position
    add_index :content_element_types, :mandatory
    add_index :content_element_types, :badge
  end
end
