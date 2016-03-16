class ChangeTypeOfValueInContentElementsFromTextToMediumtext < ActiveRecord::Migration
  def change
    change_column :content_elements, :value, :text, limit: 16.megabytes - 1
  end
end
