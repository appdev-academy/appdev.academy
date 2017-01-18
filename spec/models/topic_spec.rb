require 'rails_helper'

RSpec.describe Topic, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:topic)).to be_valid
  end
  
  context 'relationships' do
  end
  
  context 'validations' do
    context 'relationships' do
    end
    context 'fields' do
      subject { FactoryGirl.create(:topic) }
      it { should validate_presence_of(:slug) }
      it { should validate_uniqueness_of(:slug) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
    end
  end
  
  context 'set default position on create' do
    it 'should set position to be last' do
      Topic.destroy_all
      topic1 = FactoryGirl.create(:topic)
      topic2 = FactoryGirl.create(:topic)
      topic3 = FactoryGirl.create(:topic)
      
      expect(topic1.position).to eq(1)
      expect(topic2.position).to eq(2)
      expect(topic3.position).to eq(3)
    end
  end
end
