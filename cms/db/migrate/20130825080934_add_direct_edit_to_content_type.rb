class AddDirectEditToContentType < ActiveRecord::Migration
  def change
    add_column :content_types, :direct_edit, :boolean
  end
end
