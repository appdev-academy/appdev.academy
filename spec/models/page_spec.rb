require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:page)).to be_valid
  end
  
  context 'relationships' do
  end
  
  context 'validations' do
    context 'relationships' do
    end
    context 'fields' do
      subject { FactoryGirl.create(:page) }
      it { should validate_presence_of(:slug) }
      it { should validate_uniqueness_of(:slug) }
      it { should validate_presence_of(:content) }
      it { should validate_presence_of(:html_content) }
    end
  end
end