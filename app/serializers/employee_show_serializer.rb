class EmployeeShowSerializer < ActiveModel::Serializer
  attribute :first_name
  attribute :id
  attribute :last_name
  attribute :profile_picture
  attribute :position
  attribute :published
  attribute :title
  
  attribute :updated_at
  def updated_at
    object.updated_at.strftime('%B %d, %Y')
  end
end
