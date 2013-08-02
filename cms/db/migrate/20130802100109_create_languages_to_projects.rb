class CreateLanguagesToProjects < ActiveRecord::Migration
  def change
    create_table :languages_to_projects, :id => false do |t|
      t.integer :language_id
      t.integer :project_id

      t.timestamps
    end
    add_index :languages_to_projects, :project_id
    add_index :languages_to_projects, :language_id
  end
end
