class ProjectShowSerializer < ActiveModel::Serializer
  attribute :app_icon
  def app_icon
    object.app_icon.regular.url
  end
  
  attribute :content
  attribute :html_content
  attribute :html_preview
  attribute :id
  
  attribute :preview
  attribute :position
  
  attribute :tags
  def tags
    ActiveModel::Serializer::CollectionSerializer.new(object.tags, each_serializer: TagSerializer).as_json
  end
  
  attribute :title
end
