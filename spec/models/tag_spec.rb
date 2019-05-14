require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'should have a valid factory' do
    expect(FactoryBot.build(:tag)).to be_valid
  end
  
  context 'associations' do
    it { should have_and_belong_to_many(:articles) }
    it { should have_and_belong_to_many(:projects) }
  end
  
  context 'validations' do
    context 'associations' do
    end
    
    context 'fields' do
      subject { FactoryBot.create(:tag) }
      
      it { should validate_uniqueness_of(:slug).case_insensitive }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title).case_insensitive }
      
      context 'WITHOUT override the slug from the title' do
        subject { FactoryBot.build(:tag, title: nil) }
        it { should validate_presence_of(:slug) }
      end
    end
  end
end
