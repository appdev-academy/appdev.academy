FactoryGirl.define do
  factory :lesson do
    content { Faker::Lorem.paragraphs(5).join('\n') }
    html_content { "<p>#{content}</p>" }
    html_preview { "<p>#{preview}</p>" }
    image_url { Faker::Internet.url }
    is_hidden { false }
    preview { Faker::Lorem.paragraph }
    short_description { Faker::Lorem.sentence }
    title { Faker::Lorem.sentence }
  end
end
