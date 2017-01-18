class ArticleIndexSerializer < ActiveModel::Serializer
  attributes :author, :id, :is_hidden, :position, :slug, :title
  
  def author
    AuthorSerializer.new(object.author).attributes.as_json
  end
end
