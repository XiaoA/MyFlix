# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Video.create(title: "Family Guy",
             description: "You'll love spending time with Peter Griffin and his oddball family.",
             small_cover_url: "/tmp/family_guy.jpg",
             large_cover_url: "/tmp/family_guy.jpg")

Video.create(title: "Futurama",
             description: "A pizza delivery boy, cryogenically preserved for 1,000 years, adjusts to his new life in the 31st Century",
             small_cover_url: "/tmp/futurama.jpg", 
             large_cover_url: "/tmp/futurama.jpg")

Video.create(title: "Monk",
             description: "A brilliant detective, riddled with OCD and phobias, solves crimes in San Francisco, while searching for his wife's elusive killer.",
             small_cover_url: "/tmp/monk.jpg",     
             large_cover_url: "/tmp/monk_large.jpg")

Video.create(title: "South Park",
             description: "Nothing is sacred in South Park. Join Stan, Kyle, Cartman, Kenny, and the rest of the town for adventures that are both delightful and distubring.",
             small_cover_url: "/tmp/south_park.jpg",
             large_cover_url: "/tmp/south_park.jpg")


Category.create(category_name: "Animation")
Category.create(category_name: "Dramas")
Category.create(category_name: "Comedies")
