FactoryGirl.define do
  factory :project do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraphs(5).join('\n') }
    html_description { "<p>#{description}</p>" }
  end
end