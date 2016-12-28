class Project < ApplicationRecord
  # Relationships
  # Relationships validations
  # Fields validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :html_description, presence: true
end