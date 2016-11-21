class ArticleSerializer < ActiveModel::Serializer
  attributes :content, :html_content, :id, :title
end