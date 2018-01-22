FactoryGirl.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    title { Faker::Lorem.sentence(3) }
    profile_picture { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'avatar-144x144.png')) }
  end
end
