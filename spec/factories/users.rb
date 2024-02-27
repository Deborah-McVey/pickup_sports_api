FactoryBot.define do
  factory :user do
    user_name { Faker::Internet.username(specifier: 3..20, seperators: %w(_)) }
    email { Faker::Internet.email }
    first_name { Faker::Internet.first_name }
    last_name { Faker::Internet.last_name }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
