class Tag < ApplicationRecord
  # Associations
  has_and_belongs_to_many :articles
  
  # Associations' validations
  
  # Field validations
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
