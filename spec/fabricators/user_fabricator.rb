Fabricator(:user) do
  username { Faker::Lorem.word }
  email { Faker::Internet.email }
  password { 'password' }
end