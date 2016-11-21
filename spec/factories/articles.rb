FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(5).join('\n') }
    html_content { content }
  end
end