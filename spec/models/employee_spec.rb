require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.build(:employee)).to be_valid
  end
  
  context 'validations' do
    context 'fields' do
      it { should validate_presence_of(:first_name) }
      it { should validate_length_of(:first_name).is_at_least(2).is_at_most(100) }
      it { should validate_presence_of(:last_name) }
      it { should validate_length_of(:last_name).is_at_least(2).is_at_most(100) }
      it { should validate_presence_of(:position) }
    end
  end
end
