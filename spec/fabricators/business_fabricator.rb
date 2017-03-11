Fabricator(:business) do
  name { Faker::Lorem.words(2).join(' ') }
  description { Faker::Lorem.paragraph(2) }
  price { Faker::Number.between(1,4) }
end