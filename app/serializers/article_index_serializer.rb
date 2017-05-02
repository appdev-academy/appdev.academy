class ArticleIndexSerializer < ActiveModel::Serializer
  attributes :author, :html_preview, :id, :is_hidden, :position, :published_at, :slug, :tags, :title
  
  def author
    AuthorSerializer.new(object.author).attributes.as_json
  end
  
  def published_at
    object.published_at&.strftime('%B %d, %Y')
  end
  
  def tags
    ActiveModel::Serializer::CollectionSerializer.new(object.tags, each_serializer: TagSerializer).as_json
  end
end
