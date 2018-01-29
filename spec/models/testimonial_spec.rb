require 'rails_helper'

RSpec.describe Testimonial, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.build(:testimonial)).to be_valid
  end
  
  context 'validations' do
    context 'fields' do
      it { should validate_presence_of(:body) }
      it { should validate_presence_of(:company) }
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:html_body) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:profile_picture) }
      it { should validate_presence_of(:title) }
    end
  end
end
