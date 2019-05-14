FactoryBot.define do
  factory :topic do
    title { Faker::Lorem.sentence }
    slug { Faker::Internet.slug(title, '-') }
  end
end
