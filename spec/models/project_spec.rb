require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:project)).to be_valid
  end
  
  context 'relationships' do
  end
  
  context 'validations' do
    context 'relationships' do
    end
    context 'fields' do
      subject { FactoryGirl.create(:project) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:html_description) }
    end
  end
end