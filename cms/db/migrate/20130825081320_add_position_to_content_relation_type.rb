class AddPositionToContentRelationType < ActiveRecord::Migration
  def change
    add_column :content_relation_types, :position, :integer
  end
end
