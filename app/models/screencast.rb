class Screencast < ApplicationRecord
  # Callbacks
  # Set default position on create
  before_create :set_default_position
  
  # Relationships
  has_many :lessons, dependent: :destroy
  belongs_to :topic
  
  # Relationships validations
  validates :topic, presence: true
  
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
      if Screencast.count > 0
        self.position = Screencast.maximum('position') + 1
      end
    end
end
