class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :old_id
      t.integer :ref_id
      t.integer :project_id
      t.integer :content_type_id
      t.datetime :alpha_datum
      t.datetime :omega_datum
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
