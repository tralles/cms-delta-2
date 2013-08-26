class CreateContentRelations < ActiveRecord::Migration
  def change
    create_table :content_relations do |t|
      t.integer :content_relation_type_id
      t.integer :content_id
      t.integer :relative_id
      t.integer :position
      t.string :label

      t.timestamps
    end
  end
end
