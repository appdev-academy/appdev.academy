class ProjectIndexSerializer < ActiveModel::Serializer
  attribute :app_icon
  def app_icon
    object.app_icon.regular.url
  end
  
  attribute :html_preview
  attribute :id
  attribute :is_hidden
  attribute :position
  attribute :slug
  attribute :title
end
