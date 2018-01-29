FactoryGirl.define do
  factory :testimonial do
    body { Faker::Lorem.paragraph }
    company { Faker::Company.name }
    first_name { Faker::Name.first_name }
    html_body { "<p>#{body}</p>" }
    last_name { Faker::Name.last_name }
    profile_picture { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'avatar-144x144.png')) }
    title { Faker::Lorem.sentence(3) }
  end
end
