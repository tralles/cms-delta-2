class AddProjectIdToConstants < ActiveRecord::Migration
  def change
    add_column :constants, :project_id, :integer
  end
end
