require 'rails_helper'

RSpec.describe Session, type: :model do
  before :all do
    @user = FactoryBot.create(:user)
  end
  
  it 'should have a valid factory' do
    expect(FactoryBot.create(:session, user: @user)).to be_valid
  end
  
  context 'relationships' do
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    context 'relationships' do
      it { should validate_presence_of(:user) }
    end
    context 'fields' do
      subject { FactoryBot.create(:session, user: @user) }
      it { should validate_presence_of(:access_token) }
      it { should validate_uniqueness_of(:access_token) }
    end
  end
end