

# Create Users
5.times do |n|
  user_name = "User_Name_#{n}"
  user = User.create!(user_name: user_name, email: "#{user_name}@seeds.com", password: "hello_world", password_confirmation: "hello_world")
  user.confirm
  user.save
end
pete = User.create!(user_name: "CharlieHustle", email: "pete@rose.com", password: "hello_world", password_confirmation: "hello_world")
pete.confirm
pete.save


users = User.all

# Create topics
10.times do |n|
  Topic.create!(title: "Topic_#{n}", user: users.sample)
end

topics = Topic.all

# Create Bookmarks
120.times do |n|
  Bookmark.create!(url: "www.bookmark_#{n}.com", topic: topics.sample)
end



puts "Seed Finished"
puts "#{User.count} users created including #{pete.user_name}"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
