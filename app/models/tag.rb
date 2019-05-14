class Tag < ApplicationRecord
  # Callbacks
  before_validation :set_slug
  
  # Associations
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :projects
  
  # Associations' validations
  
  # Field validations
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  
  private
    def set_slug
      return unless self.title
      
      newSlug = self.title.parameterize
      if self.slug != newSlug
        self.slug = newSlug
      end
    end
end
