require 'rails_helper'

RSpec.describe Screencast, type: :model do
  before :all do
    @topic = FactoryBot.create(:topic)
  end
  
  it 'should have a valid factory' do
    expect(FactoryBot.create(:screencast, topic: @topic)).to be_valid
  end
  
  context 'relationships' do
    it { should have_many(:lessons).dependent(:destroy) }
    it { should belong_to(:topic) }
  end
  
  context 'validations' do
    context 'relationships' do
      it { should validate_presence_of(:topic) }
    end
    context 'fields' do
      subject { FactoryBot.create(:screencast, topic: @topic) }
      it { should validate_presence_of(:content) }
      it { should validate_presence_of(:html_content) }
      it { should validate_presence_of(:html_preview) }
      it { should validate_presence_of(:image_url) }
      it { should validate_presence_of(:preview) }
      it { should validate_presence_of(:short_description) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
    end
  end
  
  context 'set default position on create' do
    it 'should set position to be last' do
      Screencast.destroy_all
      screencast1 = FactoryBot.create(:screencast, topic: @topic)
      screencast2 = FactoryBot.create(:screencast, topic: @topic)
      screencast3 = FactoryBot.create(:screencast, topic: @topic)
      
      expect(screencast1.position).to eq(1)
      expect(screencast2.position).to eq(2)
      expect(screencast3.position).to eq(3)
    end
  end
end
