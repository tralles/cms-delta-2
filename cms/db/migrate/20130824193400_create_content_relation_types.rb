class CreateContentRelationTypes < ActiveRecord::Migration
  def change
    create_table :content_relation_types do |t|
      t.integer :project_id
      t.string :name
      t.string :intern
      t.integer :content_type_id
      t.integer :relative_type_id
      t.integer :relation_type

      t.timestamps
    end
  end
end
