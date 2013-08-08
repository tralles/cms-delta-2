class CreateContentTypesToBranches < ActiveRecord::Migration
  def change
    create_table :content_types_to_branches do |t|
      t.integer :branch_id
      t.integer :content_type_id

      t.timestamps
    end
  end
end
