FactoryBot.define do
  factory :tag do
    slug { Faker::Lorem.characters(8) }
    title { Faker::Lorem.characters(8) }
  end
end
