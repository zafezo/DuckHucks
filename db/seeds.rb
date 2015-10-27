# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 3.times{ 
# 	cat = Category.create!(name:Faker::Lorem.word)     
# 	7.times{ |i|
# 		latitude = 50.050715 + 0.0005*rand((7*i))
# 		longitude = 19.966032  + 0.0007*rand(7*i)
# 		lobby = Event.create!(title:Faker::Company.name,
# 						latitude:latitude,
# 						longitude: longitude)
# 						# category_id:cat)
# 	}
# }


  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    user= User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
    3.times{ 
		latitude = 50.050715 + 0.0005*rand((70))
		longitude = 19.966032  + 0.0007*rand(70)
		lobby = Event.create!(title:Faker::Company.name,
						latitude:latitude,
						longitude: longitude,
						user_id:user.id)
						# category_id:cat)
	}
  end

# Event.delete_all
# User.delete_all