class ArticleImageSerializer < ActiveModel::Serializer
  attributes :id, :regular, :thumb
  
  def regular
    object.image.regular.url
  end
  
  def thumb
    object.image.thumb.url
  end
end