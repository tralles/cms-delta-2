class CreateBranchRoutes < ActiveRecord::Migration
  def change
    create_table :branch_routes do |t|
      t.integer :branch_id
      t.string :language
      t.string :name
      t.string :route
      t.string :jump

      t.timestamps
    end
    
    add_index :branch_routes, :branch_id
    add_index :branch_routes, :language
  end
end
