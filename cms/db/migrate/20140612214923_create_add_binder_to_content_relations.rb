class CreateAddBinderToContentRelations < ActiveRecord::Migration
  def change
    add_column :content_relation_types, :binder_type_id, :integer
    add_index :content_relation_types, :binder_type_id

    add_column :content_relations, :binder_id, :integer
    add_index :content_relations, :binder_id
  end
end
