class TestimonialIndexSerializer < ActiveModel::Serializer
  attribute :company
  attribute :first_name
  attribute :id
  attribute :last_name
  attribute :position
  
  attribute :profile_picture
  def profile_picture
    object.profile_picture.thumb.url
  end
  
  attribute :published
  attribute :title
end
