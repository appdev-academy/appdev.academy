FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(5).join('\n') }
    html_content { "<p>#{content}</p>" }
    preview { Faker::Lorem.paragraph }
    html_preview { "<p>#{preview}</p>" }
  end
end