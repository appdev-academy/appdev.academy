require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'should have a valid factory' do
    expect(FactoryBot.create(:project)).to be_valid
  end
  
  context 'relationships' do
  end
  
  context 'validations' do
    context 'relationships' do
    end
    context 'fields' do
      subject { FactoryBot.create(:project) }
      it { should validate_presence_of(:content) }
      it { should validate_presence_of(:html_content) }
      it { should validate_presence_of(:html_preview) }
      it { should validate_presence_of(:preview) }
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
    end
  end
  
  context 'default position on create' do
    it 'should set position to be last' do
      Project.destroy_all
      project1 = FactoryBot.create(:project)
      project2 = FactoryBot.create(:project)
      project3 = FactoryBot.create(:project)
      
      expect(project1.position).to eq(1)
      expect(project2.position).to eq(2)
      expect(project3.position).to eq(3)
    end
  end
end