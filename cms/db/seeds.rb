# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!({:email => "tralles@qb-it.de", :name => 'Marco', :surname => 'Tralles', :admin => true, :password => "initialp4ssword", :password_confirmation => "initialp4ssword" })

languages = Constant.create!({ :category => 'languages', :name => 'Deutsch', :value => 'de', :art => 'String' })
languages = Constant.create!({ :category => 'languages', :name => 'Englisch', :value => 'en', :art => 'String' })

fields = Constant.create!({ :category => 'fields', :name => 'Text : Einzeilig', :value => 1, :art => 'String' })
fields = Constant.create!({ :category => 'fields', :name => 'Text : Mehrzeilig', :value => 2, :art => 'String' })

