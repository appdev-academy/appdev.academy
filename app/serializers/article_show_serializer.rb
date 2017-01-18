class ArticleShowSerializer < ActiveModel::Serializer
  attributes :author, :content, :html_content, :html_preview, :id, :image_url, :is_hidden, :preview, :published_at, :short_description, :title, :updated_at
  
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
  
  def updated_at
    object.updated_at.strftime('%B %d, %Y')
  end
end
