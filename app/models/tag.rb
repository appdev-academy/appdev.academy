class Tag < ApplicationRecord
  # Associations
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :projects
  
  # Associations' validations
  
  # Field validations
  validates :slug, presence:true, uniqueness: { case_sensitive: false }
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
