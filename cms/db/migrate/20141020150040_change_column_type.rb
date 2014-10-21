class ChangeColumnType < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'mysql'
      change_column :permissions, :subject_id, :integer
    elsif ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'postgres'
      change_column :permissions, :subject_id, 'integer USING CAST("subject_id" AS integer)'
    end

  end
  def down
    change_column :permissions, :subject_id, :string
  end
end
