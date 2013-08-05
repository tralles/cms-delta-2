class CreateContentElements < ActiveRecord::Migration
  def change
    create_table :content_elements do |t|
      t.integer :content_id
      t.integer :content_element_type_id
      t.string :language
      t.text :value
      t.integer :status

      t.timestamps
    end
    
    add_index :content_elements, :content_id
    add_index :content_elements, :content_element_type_id
    add_index :content_elements, :language
  end
end
