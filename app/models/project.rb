class Project < ApplicationRecord
  # Callbacks
  before_create :set_default_position
  
  # Relationships
  # Relationships validations
  # Fields validations
  validates :content, presence: true
  validates :html_content, presence: true
  validates :html_preview, presence: true
  validates :preview, presence: true
  validates :title, presence: true, uniqueness: true
  
  private
    def set_default_position
      self.position = 1
      if Project.count > 0
        self.position = Project.maximum('position') + 1
      end
    end
end