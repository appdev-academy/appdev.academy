require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:article)).to be_valid
  end
  
  context 'relationships' do
  end
  
  context 'validations' do
    context 'relationships' do
    end
    context 'fields' do
      subject { FactoryGirl.create(:article) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
      it { should validate_presence_of(:content) }
      it { should validate_presence_of(:html_content) }
    end
  end
end