# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


animation = Category.create(category_name: "Animation")
dramas = Category.create(category_name: "Dramas")
comedies = Category.create(category_name: "Comedies")

Video.create(title: "Prison Break",
             description: "Michael Scofield got himself locked up in a prison he helped design. But can you get his brother out before it's too late?",
             category: dramas,
             small_cover_url: "/tmp/prison_break.jpg",
             large_cover_url: "/tmp/prison_break_large.jpg")

Video.create(title: "Friends",
             description: "Laugh along with these six twenty-something friends in New York.",
             category: comedies,
             small_cover_url: "/tmp/friends.jpg",
             large_cover_url: "/tmp/friends_large.jpg")

Video.create(title: "White Collar",
             description: "Brilliant Conman Neal Caffrey helps the FBI catch bad guys, while plotting capers of his own.",
             category: dramas,
             small_cover_url: "/tmp/white_collar.jpg",
             large_cover_url: "/tmp/white_collar_large.jpg")

Video.create(title: "Fraiser",
             description: "Lovably-pretentious Frasier and his family enjoy many hilarious misadventures in Seattle.",
             category: comedies,
             small_cover_url: "/tmp/frasier.jpg",
             large_cover_url: "/tmp/frasier_large.jpg")

Video.create(title: "Arrow",
             description: "Join Team Oliver as they fight to keep the streets of Starling City safe.",
             category: dramas,
             small_cover_url: "/tmp/arrow_cast.jpg",
             large_cover_url: "/tmp/arrow_cast.jpg")

Video.create(title: "Chuck",
             description: "When Chuck Bartowski gets a top-secret computer program implanted into his brain, he finds out that being a spy is not as easy as it looks.",
             category: dramas,
             small_cover_url: "/tmp/chuck.jpg",
             large_cover_url: "/tmp/chuck_large.jpg")

Video.create(title: "The Simpsons",
             description: "Laugh along with everyone's favorite family from Springfield.",
             category: animation,
             small_cover_url: "/tmp/simpsons.png",
             large_cover_url: "/tmp/simpsons_large.jpg")

Video.create(title: "Futurama",
             description: "A pizza delivery boy, cryogenically preserved for 1,000 years, adjusts to his new life in the 31st Century",
             category: animation,
             small_cover_url: "/tmp/futurama.jpg",
             large_cover_url: "/tmp/futurama.jpg")

Video.create(title: "Monk",
             description: "A brilliant detective, riddled with OCD and phobias, solves crimes in San Francisco, while searching for his wife's elusive killer.",
             category: dramas,
             small_cover_url: "/tmp/monk.jpg",     
             large_cover_url: "/tmp/monk_large.jpg")

Video.create(title: "South Park",
             description: "Nothing is sacred in South Park. Join Stan, Kyle, Cartman, Kenny, and the rest of the town for adventures that are both delightful and distubring.",
             category: animation,
             small_cover_url: "/tmp/south_park.jpg",
             large_cover_url: "/tmp/south_park.jpg")

Video.create(title: "Family Guy",
             description: "You'll love spending time with Peter Griffin and his oddball family.",
             category: animation,
             small_cover_url: "/tmp/family_guy.jpg",
             large_cover_url: "/tmp/family_guy.jpg")




