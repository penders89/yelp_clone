Fabricator(:review) do
  content { Faker::Lorem.paragraph(2) }
  rating { Faker::Number.between(1,5) }
  user
  business
end