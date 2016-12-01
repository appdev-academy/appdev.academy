class User < ApplicationRecord
  # Relationships
  has_many :sessions, dependent: :destroy
  
  # Relationships validations
  # Fields validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  
  # Password authentication
  has_secure_password
end