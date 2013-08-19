class AddInternToProject < ActiveRecord::Migration
  def change
    add_column :projects, :intern, :string
  end
end
