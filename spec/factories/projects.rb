FactoryBot.define do
  factory :project do
    app_icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'avatar-144x144.png')) }
    content { Faker::Lorem.paragraphs(5).join('\n') }
    html_content { "<p>#{content}</p>" }
    preview { Faker::Lorem.paragraphs(5).join('\n') }
    html_preview { "<p>#{preview}</p>" }
    title { Faker::Lorem.sentence }
    is_hidden { false }
  end
end
