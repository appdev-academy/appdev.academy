class ProjectShowSerializer < ActiveModel::Serializer
  attributes :content, :html_content, :html_preview, :id, :preview, :position, :tags, :title
  
  def tags
    ActiveModel::Serializer::CollectionSerializer.new(object.tags, each_serializer: TagSerializer).as_json
  end
end
