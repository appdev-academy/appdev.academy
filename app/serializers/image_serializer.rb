class ImageSerializer < ActiveModel::Serializer
  attributes :id, :original, :regular, :thumb
  
  def original
    object.image.url
  end
  
  def regular
    object.image.regular.url
  end
  
  def thumb
    object.image.thumb.url
  end
end