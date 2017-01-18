class User < ApplicationRecord
  # Relationships
  has_many :articles, class_name: 'Article', foreign_key: 'author_id', dependent: :destroy
  has_many :sessions, dependent: :destroy
  
  # Relationships validations
  
  # Fields validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, confirmation: true
  
  # Password authentication
  has_secure_password
  
  # Returns full name for user
  def full_name
    "#{first_name} #{last_name}"
  end
end
