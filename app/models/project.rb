class Project < ApplicationRecord
  # Callbacks
  # Set default position on create
  before_create :set_default_position
  # Set slug on create/update
  after_save :set_slug
  
  # Associations
  has_many :gallery_images, dependent: :destroy
  has_and_belongs_to_many :tags
  
  # Associations validations
  
  # Fields validations
  validates :content, presence: true
  validates :html_content, presence: true
  validates :html_preview, presence: true
  validates :preview, presence: true
  validates :title, presence: true, uniqueness: true
  
  # Make link_to generate URLs with slug, instead of ID
  def to_param
    self.slug
  end
  
  private
    def set_default_position
      self.position = 1
      if Project.count > 0
        self.position = Project.maximum('position') + 1
      end
    end
    
    def set_slug
      newSlug = "#{self.id}-#{self.title.parameterize}"
      if self.slug != newSlug
        self.slug = newSlug
        self.save
      end
    end
end
