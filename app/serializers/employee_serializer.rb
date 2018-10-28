class EmployeeSerializer < ActiveModel::Serializer
  attribute :facebook_url
  attribute :first_name
  attribute :github_url
  attribute :id
  attribute :last_name
  attribute :linkedin_url
  attribute :motivation
  attribute :position
  
  attribute :profile_picture
  def profile_picture
    object.profile_picture.rect_square.url
  end
  
  attribute :published
  attribute :title
  attribute :twitter_url
  
  attribute :updated_at
  def updated_at
    object.updated_at.strftime('%B %d, %Y')
  end
end
