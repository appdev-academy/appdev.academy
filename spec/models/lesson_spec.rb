require 'rails_helper'

RSpec.describe Lesson, type: :model do
  before :all do
    topic = FactoryBot.create(:topic)
    @screencast = FactoryBot.create(:screencast, topic: topic)
  end
  
  it 'should have a valid factory' do
    expect(FactoryBot.create(:lesson, screencast: @screencast)).to be_valid
  end
  
  context 'relationships' do
    it { should belong_to(:screencast) }
  end
  
  context 'validations' do
    context 'relationships' do
      it { should validate_presence_of(:screencast) }
    end
    context 'fields' do
      subject { FactoryBot.create(:lesson, screencast: @screencast) }
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
      Lesson.destroy_all
      lesson1 = FactoryBot.create(:lesson, screencast: @screencast)
      lesson2 = FactoryBot.create(:lesson, screencast: @screencast)
      lesson3 = FactoryBot.create(:lesson, screencast: @screencast)
      
      expect(lesson1.position).to eq(1)
      expect(lesson2.position).to eq(2)
      expect(lesson3.position).to eq(3)
    end
  end
end
