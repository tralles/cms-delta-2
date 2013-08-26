class ChangeContentElementTypeFieldTypeToString < ActiveRecord::Migration
  def self.up
    change_table :content_element_types do |t|
      t.change :field_type, :string
    end
  end
  def self.down
    change_table :content_element_types do |t|
      t.change :field_type, :integer
    end
  end
end
