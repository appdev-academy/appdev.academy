class EmployeeShowSerializer < ActiveModel::Serializer
  attribute :first_name
  attribute :id
  attribute :last_name
  
  attribute :profile_picture
  def profile_picture
    object.profile_picture.thumb.url
  end
  
  attribute :position
  attribute :published
  attribute :title
  
  attribute :updated_at
  def updated_at
    object.updated_at.strftime('%B %d, %Y')
  end
end
