class ChangeSubjectIdType < ActiveRecord::Migration
  def up
    change_column :permissions, :subject_id, 'integer USING CAST(subject_id AS integer)'
  end
end
