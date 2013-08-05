class CreateConstantRelations < ActiveRecord::Migration
  def change
    create_table :constant_relations do |t|
      t.integer :constant_id
      t.references :configurable, polymorphic: true
      t.timestamps
    end
  end
end
