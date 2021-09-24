User.all.map(&:destroy)
Topic.all.map(&:destroy)
FavoriteBlogpost.all.map(&:destory)

users = [
  User.new(admin: true, email: 'admin@klimabox.com', password: 'admin1234', password_confirmation: 'admin1234'),
  User.new(admin: false, email: 'nutzer@klimabox.com', password: 'nutzer1234', password_confirmation: 'nutzer1234'),
]
users.each do |user|
  user.skip_activation_success_email = true
  user.skip_activation_needed_email = true
  user.save!
  user.activate!
end

topics = [
  Topic.new(name: "Mobilität"),
  Topic.new(name: "Bauen & Sanieren"),
  Topic.new(name: "Energie"),
  Topic.new(name: "Ernährung"),
  Topic.new(name: "Kleidung")
]


topics.each.map(&:save)