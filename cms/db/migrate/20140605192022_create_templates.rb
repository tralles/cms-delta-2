class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :project_id
      t.string :action
      t.string :title
      t.text :code

      t.timestamps
    end
  end
end
