class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.integer :project_id
      t.string :protocol, :default => 'http://'
      t.string :host
      t.boolean :primary

      t.timestamps
    end
  end
end
