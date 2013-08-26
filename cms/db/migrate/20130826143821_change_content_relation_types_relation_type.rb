class ChangeContentRelationTypesRelationType < ActiveRecord::Migration
  def self.up
    change_table :content_relation_types do |t|
      t.change :relation_type, :string
    end
  end
  def self.down
    change_table :content_relation_types do |t|
      t.change :relation_type, :integer
    end
  end
end
