FactoryBot.define do
  factory :estimate_request do
    name { Faker::Name.first_name + Faker::Name.last_name }
    company { Faker::Company.name }
    email { Faker::Internet.email }
    subject { Faker::Lorem.sentence }
    budget { Faker::Number.positive }
    details { Faker::Lorem.paragraph }
  end
end
