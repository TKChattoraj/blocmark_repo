require 'factory_girl_rails'

# Create Users
5.times do
  random = rand(1000)
  user_name = "User_Name_#{random}"
  user = User.create!(user_name: user_name, email: "#{user_name}@seeds.com", password: "hello_world", password_confirmation: "hello_world")
  user.confirm
end


users = User.all

# Create tables
10.times do
  random = rand(1000)
  Topic.create!(title: "Title_#{random}", user: users.sample)
end

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
