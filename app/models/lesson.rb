class Lesson < ApplicationRecord
  # Callbacks
  # Set default position on create
  before_create :set_default_position
  
  # Relationships
  belongs_to :screencast
  
  # Relationships validations
  validates :screencast, presence: true
  
  # Fields validations
  validates :content, presence: true
  validates :html_content, presence: true
  validates :html_preview, presence: true
  validates :image_url, presence: true
  validates :preview, presence: true
  validates :short_description, presence: true
  validates :title, presence: true, uniqueness: true
  
  private
    def set_default_position
      self.position = 1
      if Lesson.count > 0
        self.position = Lesson.maximum('position') + 1
      end
    end
end
