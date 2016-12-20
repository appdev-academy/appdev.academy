require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  
  context 'relationships' do
    it { should have_many(:articles).class_name('Article').with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:sessions).dependent(:destroy) }
  end
  
  context 'validations' do
    context 'relationships' do
    end
    context 'fields' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:password) }
    end
  end
end