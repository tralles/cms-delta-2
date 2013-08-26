class AddSysToConstant < ActiveRecord::Migration
  def change
    add_column :constants, :sys, :boolean
  end
end
