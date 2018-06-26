class GalleryImage < ApplicationRecord
  # Callbacks
  after_save :update_measures
  
  # Uploaders
  mount_uploader :image, GalleryImageUploader
  
  # Associations
  belongs_to :project
  
  # Associations validations
  validates :project, presence: true
  
  # Field validations
  
  def update_measures
    if image.url
      file = MiniMagick::Image.open(g.image.url)
      update_columns(width: file.width, height: file.height)
    end
  end
end
