require 'rails_helper'

RSpec.describe Article, type: :model do
  before :all do
    @author = FactoryGirl.create(:user)
  end
  
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:article, author: @author)).to be_valid
  end
  
  context 'relationships' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
  end
  
  context 'validations' do
    context 'relationships' do
      it { should validate_presence_of(:author) }
    end
    context 'fields' do
      subject { FactoryGirl.create(:article, author: @author) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
      it { should validate_presence_of(:content) }
      it { should validate_presence_of(:html_content) }
      it { should validate_presence_of(:preview) }
      it { should validate_presence_of(:html_preview) }
    end
  end
  
  context 'set default position on create' do
    it 'should set position to be last' do
      Article.destroy_all
      article1 = FactoryGirl.create(:article, author: @author)
      article2 = FactoryGirl.create(:article, author: @author)
      article3 = FactoryGirl.create(:article, author: @author)
      
      expect(article1.position).to eq(1)
      expect(article2.position).to eq(2)
      expect(article3.position).to eq(3)
    end
  end
end