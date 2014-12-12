class AddCssToProject < ActiveRecord::Migration
  def change
    add_column :projects, :css, :text
  end
end
