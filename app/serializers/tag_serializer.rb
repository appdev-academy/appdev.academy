class TagSerializer < ActiveModel::Serializer
  attribute :id
  attribute :slug
  attribute :title
  
  attribute :articles_count
  def articles_count
    object.articles.count
  end
  
  attribute :projects_count
  def projects_count
    object.projects.count
  end
end
