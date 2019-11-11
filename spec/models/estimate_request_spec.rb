require 'rails_helper'

RSpec.describe EstimateRequest, type: :model do
  it 'should have a valid factory' do
    expect(FactoryBot.build(:estimate_request)).to be_valid
  end
  
  context 'validations' do
    context 'fields' do
      subject { FactoryBot.create(:estimate_request) }
      
      it { should validate_presence_of(:budget) }
      it { should validate_numericality_of(:budget).is_greater_than_or_equal_to(0.0) }
      it { should validate_presence_of(:details) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:subject) }
      
      it 'should validate :email format' do
        invalid_estimate_request_1 = FactoryBot.build(:estimate_request, email: '@mail.com')
        invalid_estimate_request_2 = FactoryBot.build(:estimate_request, email: '12@mail')
        invalid_estimate_request_3 = FactoryBot.build(:estimate_request, email: '12.mail.com')
        
        expect(invalid_estimate_request_1.valid?).to eq(false)
        expect(invalid_estimate_request_1.errors.full_messages.first).to eq('Email address format is incorrect.')
        
        expect(invalid_estimate_request_2.valid?).to eq(false)
        expect(invalid_estimate_request_2.errors.full_messages.first).to eq('Email address format is incorrect.')
        
        expect(invalid_estimate_request_3.valid?).to eq(false)
        expect(invalid_estimate_request_3.errors.full_messages.first).to eq('Email address format is incorrect.')
      end
    end
  end
end
