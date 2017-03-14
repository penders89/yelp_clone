User.create(username: "Test User", email: "test@example.com", password: 'password')

20.times do 
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: 'password')
end

50.times do 
  Business.create(price: Faker::Number.between(1,5), name: Faker::Company.name, description: Faker::Lorem.paragraphs(3).join(' '))
end

10.times do |x|
  Faker::Number.between(5,15).times do |y|
    Review.create(business: Business.find(x + 1), user: User.find(y + 1), content: Faker::Lorem.paragraphs(2).join(' '), rating: Faker::Number.between(1,5))
  end 
end