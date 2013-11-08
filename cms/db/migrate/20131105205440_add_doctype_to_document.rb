class AddDoctypeToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :doctype, :integer
  end
end
