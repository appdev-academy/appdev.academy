FactoryGirl.define do
  factory :session do
    access_token { Session.new_access_token }
  end
end