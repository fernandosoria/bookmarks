require 'faker'

# Create Users
5.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

# Create Tags
25.times do
  Tag.create(
    label: Faker::Lorem.word
  )
end
tags = Tag.all

# Create bookmarks
50.times do
  Bookmark.create(
    user: users.sample,
    tags: [tags.sample, tags.sample],
    url: Faker::Internet.url
  )
end


#Create an member user
member = User.create(
  name: 'Member Name',
  email: 'member@example.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Tag.count} tags created"
puts "#{Bookmark.count} bookmarks created"