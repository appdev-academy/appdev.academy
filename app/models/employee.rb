class Employee < ApplicationRecord
  mount_uploader :profile_picture, ProfilePictureUploader
  
  # Fields validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :title, presence: true
  validates_presence_of :profile_picture
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
