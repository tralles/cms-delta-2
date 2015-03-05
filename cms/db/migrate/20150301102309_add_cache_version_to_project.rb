class AddCacheVersionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :cache_version, :datetime
  end
end
