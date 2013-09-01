class AddAnalyticsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :analytics, :string
  end
end
