class ArticleShowSerializer < ActiveModel::Serializer
  attributes :content, :html_content, :html_preview, :id, :is_hidden, :preview, :published_at, :title, :updated_at
  
  def published_at
    if object.published_at
      object.published_at.strftime('%B %d, %Y')
    else
      nil
    end
  end
  
  def updated_at
    if object.updated_at
      object.updated_at.strftime('%B %d, %Y')
    else
      nil
    end
  end
end