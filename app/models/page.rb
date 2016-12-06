class Page < ApplicationRecord
  # Relationships
  # Relationships validations
  # Fields validations
  validates :slug, presence: true, uniqueness: true
  validates :content, presence: true
  validates :html_content, presence: true
end