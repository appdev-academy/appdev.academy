class Topic < ApplicationRecord
  # Callbacks
  # Set default position on create
  before_create :set_default_position
  
  # Relationships
  # Relationships validations
  
  # Fields validations
  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  
  private
    def set_default_position
      self.position = 1
      if Topic.count > 0
        self.position = Topic.maximum('position') + 1
      end
    end
end
