require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'should have a valid factory' do
    expect(FactoryBot.create(:tag)).to be_valid
  end
  
  context 'associations' do
    it { should have_and_belong_to_many(:articles) }
  end
  
  context 'validations' do
    context 'associations' do
    end
    context 'fields' do
      subject { FactoryBot.build(:tag) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title).case_insensitive }
    end
  end
end
