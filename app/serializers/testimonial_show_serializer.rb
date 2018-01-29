class TestimonialShowSerializer < ActiveModel::Serializer
  attribute :body
  attribute :company
  attribute :first_name
  attribute :html_body
  attribute :id
  attribute :last_name
  attribute :position
  
  attribute :profile_picture
  def profile_picture
    object.profile_picture.thumb.url
  end
  
  attribute :published
  attribute :title
  
  attribute :updated_at
  def updated_at
    object.updated_at.strftime('%B %d, %Y')
  end
end
