class CreateTemplatables < ActiveRecord::Migration
  def change
    create_table :templatables do |t|
      t.integer :project_id
      t.integer :template_id
      t.string :templatable_type
      t.integer :templatable_id

      t.timestamps
    end
  end
end
