class AddMetaToContentToBranches < ActiveRecord::Migration
  def change
    add_column :content_to_branches, :link, :boolean
    add_column :content_to_branches, :caption, :string

    add_index :content_to_branches, :link
  end
end
