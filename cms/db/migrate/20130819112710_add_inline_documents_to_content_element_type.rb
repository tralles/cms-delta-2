class AddInlineDocumentsToContentElementType < ActiveRecord::Migration
  def change
    add_column :content_element_types, :inline_documents, :boolean
  end
end
