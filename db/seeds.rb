# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#creating test user
# User.create({
#   email: "test123@gmail.com",
#   password: "test123"
# })

# creating itineraries
# 5.times do |i|
#   Itinerary.create({
#       user_id: 1,
#       title: "Itinerary #{i + 1}",
#       :country => Faker::Address.country,
#       :bannerUrl => Faker::Placeholdit.image,
#       :startDate => Faker::Date.backward(2),
#       :endDate => Faker::Date.forward(2)
#   })
# end


# creating activities
# 3.times do |i|
#   Activity.create({
#     itinerary_id: 1,
#     day: 1,
#     :place => Faker::HarryPotter.location,
#     :latitude => Faker::Address.latitude,
#     :longitude => Faker::Address.longitude,
#     :blurb => Faker::Lorem.sentence,
#     :content => Faker::Lorem.paragraph(5)
#     })
# end

# creating photos
# 3.times do |j|
#   3.times do
#     Photo.create({
#       activity_id: "#{j + 1}",
#       :url => Faker::Placeholdit.image
#       })
#   end
# end
