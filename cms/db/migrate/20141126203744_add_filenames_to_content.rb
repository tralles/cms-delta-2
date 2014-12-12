class AddFilenamesToContent < ActiveRecord::Migration
  def down
    remove_column :contents, :filenames
  end

  def up
    add_column :contents, :filenames, :text

    Content.all.each do |c|
      c.setFileNames
    end
  end
end
