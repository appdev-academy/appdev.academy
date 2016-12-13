class Article < ApplicationRecord
  # Relationships
  # Relationships validations
  # Fields validations
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :html_content, presence: true
  validates :preview, presence: true
  validates :html_preview, presence: true
end