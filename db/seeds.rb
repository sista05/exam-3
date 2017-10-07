# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



  
100.times do |n|
  email = Faker::Internet.email
  name = Faker::Internet.user_name
  password = "password"
  id = rand(0..10000)
  provider = rand(0..10000)
  
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               id: id,
               provider: provider,
               name: name,
               )

  title   =  Faker::Lorem.sentence  
  content =  Faker::Lorem.sentence
     
  Topic.create!(
            user_id: id,
            content:  content,
            title:  title,
            id: n,
               )      
  
  context =  Faker::Lorem.sentence
  Comment.create!(
            user_id: id,
            topic_id: n,
            content:  context,
               )  
               
end

