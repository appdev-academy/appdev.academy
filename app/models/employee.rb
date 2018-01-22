class Employee < ApplicationRecord
  mount_uploader :profile_picture, AvatarUploader
  
  # Fields validations
  validates :first_name, presence: true, length: { in: 2..100 }
  validates :last_name, presence: true, length: { in: 2..100 }
  validates :position, presence: true
end
