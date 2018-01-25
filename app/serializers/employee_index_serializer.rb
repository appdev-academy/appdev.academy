class EmployeeIndexSerializer < ActiveModel::Serializer
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
end
