class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :project_id
      t.attachment :document
      t.integer :width
      t.integer :height
      t.timestamps
    end
  end
end
