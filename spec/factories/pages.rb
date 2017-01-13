FactoryGirl.define do
  factory :page do
    slug { Faker::Lorem.characters(10) }
    content { Faker::Lorem.paragraphs(5).join('\n') }
    html_content { content }
  end
end
