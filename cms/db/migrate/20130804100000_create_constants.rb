class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants do |t|
      t.string :category
      t.string :name
      t.text :value
      t.string :art

      t.timestamps
    end
  end
end
