class Testimonial < ApplicationRecord
  mount_uploader :profile_picture, AvatarUploader
  
  # Fields validations
  validates :body, presence: true
  validates :company, presence: true
  validates :first_name, presence: true
  validates :html_body, presence: true
  validates :last_name, presence: true
  validates :title, presence: true
  validates_presence_of :profile_picture
end
