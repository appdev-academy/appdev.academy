class ProjectShowSerializer < ActiveModel::Serializer
  attribute :app_icon
  def app_icon
    object.app_icon.regular.url
  end
  
  attribute :app_store_url
  attribute :content
  attribute :google_play_url
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
