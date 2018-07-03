# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
password = Faker::Internet.password 

user = User.create(
  username: Faker::Name.name,
  email: Faker::Internet.email,
  password: password,
  password_confirmation: password,
)

50.times do
  bucketlist = Bucketlist.create(name: Faker::Lorem.word, created_by: user.id)
  bucketlist.items.create(name: Faker::Lorem.word, done: false)
end