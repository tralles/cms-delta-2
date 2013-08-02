# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!({:email => "tralles@qb-it.de", :admin => true, :password => "initialp4ssword", :password_confirmation => "initialp4ssword" })

de = Language.create!({ :sign => 'de', :name => 'Deutsch' })
en = Language.create!({ :sign => 'en', :name => 'Englisch' })