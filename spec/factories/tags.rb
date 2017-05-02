FactoryGirl.define do
  factory :tag do
    title { Faker::Lorem.characters(8) }
  end
end
