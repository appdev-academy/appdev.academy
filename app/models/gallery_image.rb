class GalleryImage < ApplicationRecord
  mount_uploader :image, GalleryImageUploader
  
  # Delete empty directory when GalleryImage is deleted
  before_destroy :remember_id
  after_destroy :remove_empty_directory
  
  # Associations
  belongs_to :project
  
  # Associations validations
  validates :project, presence: true
  
  # Validations
  
  protected
    def remember_id
      @id = id
    end
    
    def remove_empty_directory
      FileUtils.remove_dir("#{Rails.root}/public/uploads/gallery_images/#{@id}", force: true)
    end
end
