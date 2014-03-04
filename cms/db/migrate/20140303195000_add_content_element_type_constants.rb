class AddContentElementTypeConstants < ActiveRecord::Migration
  def up
    Constant.create!({ :category => 'fields', :name => 'Auswahl : Konstante (matches intern)', :value => 'Constant', :art => 'reference', :sys => true })
  end
end


