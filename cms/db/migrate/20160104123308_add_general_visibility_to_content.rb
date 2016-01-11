class AddGeneralVisibilityToContent < ActiveRecord::Migration
  def change
    add_column :contents, :hidden, :boolean, default: false
  end
end
