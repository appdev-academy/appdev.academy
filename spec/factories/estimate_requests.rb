FactoryBot.define do
  factory :estimate_request do
    name { Faker::Name.first_name + Faker::Name.last_name }
    company { Faker::Company.name }
    email { Faker::Internet.email }
    subject { Faker::Lorem.sentence }
    deadline { Faker::Date.between(from: Date.today, to: 30.days.from.now) }
    budget { Faker::Number.decimal(l_digits: 2) }
    details { Faker::Lorem.paragraph }
  end
end
