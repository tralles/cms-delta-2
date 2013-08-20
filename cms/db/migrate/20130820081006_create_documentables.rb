class CreateDocumentables < ActiveRecord::Migration
  def change
    create_table :documentables do |t|
      t.integer :project_id
      t.integer :document_id
      t.string :documentable_type
      t.integer :documentable_id
      t.integer :doctype
      t.string :title
      t.text :info
      t.integer :position

      t.timestamps
    end
  end
end
