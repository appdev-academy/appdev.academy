class Article < ApplicationRecord
  # Callbacks
  # Set default position on create
  before_create :set_default_position
  # Set slug on create/update
  after_save :set_slug
  
  # Relationships
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  
  # Relationships validations
  validates :author, presence: true
  
  # Fields validations
  validates :content, presence: true
  validates :html_content, presence: true
  validates :html_preview, presence: true
  validates :image_url, presence: true
  validates :preview, presence: true
  validates :short_description, presence: true
  validates :title, presence: true, uniqueness: true
  
  # Make link_to generate URLs with slug, instead of ID
  def to_param
    self.slug
  end
  
  private
    def set_default_position
      self.position = 1
      if Article.count > 0
        self.position = Article.maximum('position') + 1
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
