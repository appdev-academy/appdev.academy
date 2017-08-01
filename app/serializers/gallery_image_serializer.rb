class GalleryImageSerializer < ActiveModel::Serializer
  attribute :id
  
  attribute :original
  def original
    object.image.url
  end
  
  attribute :thumb
  def thumb
    object.image.thumb.url
  end
end
