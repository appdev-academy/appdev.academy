FactoryGirl.define do
  factory :project do
    content { Faker::Lorem.paragraphs(5).join('\n') }
    html_content { "<p>#{content}</p>" }
    preview { Faker::Lorem.paragraphs(5).join('\n') }
    html_preview { "<p>#{preview}</p>" }
    title { Faker::Lorem.sentence }
    is_hidden { false }
  end
end