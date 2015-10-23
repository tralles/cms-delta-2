# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!({:email => "admin@your-domain.tld", :name => 'Admin', :surname => 'Superuser', :admin => true, :password => "initialp4ssword", :password_confirmation => "initialp4ssword" })

languages = Constant.create!({ :category => 'languages', :name => 'Deutsch', :value => 'de', :art => 'String', :sys => true })
languages = Constant.create!({ :category => 'languages', :name => 'Englisch', :value => 'en', :art => 'String', :sys => false })

fields = Constant.create!({ :category => 'fields', :name => 'Auswahl : Datum', :value => 'date', :art => 'Date', :sys => true })
fields = Constant.create!({ :category => 'fields', :name => 'Auswahl : Uhrzeit', :value => 'time', :art => 'Text', :sys => true })

fields = Constant.create!({ :category => 'fields', :name => 'Auswahl : Ziel-Inhaltstyp (matches intern)', :value => 'ContentType', :art => 'reference', :sys => true })
fields = Constant.create!({ :category => 'fields', :name => 'Auswahl : Konstante (matches intern)', :value => 'Constant', :art => 'reference', :sys => true })

fields = Constant.create!({ :category => 'fields', :name => 'Checkbox', :value => 'boolean', :art => 'Checkbox', :sys => true })

fields = Constant.create!({ :category => 'fields', :name => 'Text : Einzeilig', :value => 'textfield', :art => 'String', :sys => true })
fields = Constant.create!({ :category => 'fields', :name => 'Text : Mehrzeilig', :value => 'textarea', :art => 'Text', :sys => true })

fields = Constant.create!({ :category => 'relations', :name => 'n:m', :value => 'n:m', :art => 'relation', :sys => true })
