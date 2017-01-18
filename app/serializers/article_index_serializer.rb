class ArticleIndexSerializer < ActiveModel::Serializer
  attributes :author, :id, :is_hidden, :position, :published_at, :slug, :title
  
  def author
    AuthorSerializer.new(object.author).attributes.as_json
  end
  
  def published_at
    if object.published_at
      object.published_at.strftime('%B %d, %Y')
    else
      nil
    end
  end
end
