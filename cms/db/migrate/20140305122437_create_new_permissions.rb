class CreateNewPermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :action
      t.string :subject_class
      t.string :subject_id
      t.boolean :inverse

      t.timestamps
    end
  end
end
