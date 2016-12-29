class Project < ApplicationRecord
  # Callbacks
  before_create :set_default_position
  
  # Relationships
  # Relationships validations
  # Fields validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :html_description, presence: true
  
  private
    def set_default_position
      self.position = 1
      if Project.count > 0
        self.position = Project.maximum('position') + 1
      end
    end
end