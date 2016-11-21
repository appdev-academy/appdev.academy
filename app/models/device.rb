class Device < ApplicationRecord
  # Constants
  APP_TYPES = ['native', 'browser']
  OPERATIONAL_SYSTEMS = ['iOS', 'macOS']
  
  # Relationships
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  
  # Relationships validations
  validates :owner, presence: true
  
  # Fields validations
  validates :access_token, presence: true, uniqueness: true
  validates :app_type, presence: true, inclusion: { in: Device::APP_TYPES }
  validates :name, presence: true
  validates :operational_system, presence: true, inclusion: { in: Device::OPERATIONAL_SYSTEMS }
  
  # Generates new unique access token
  def self.new_access_token
    # Generate new token
    new_token = SecureRandom.hex(16)
    
    # Call this function until new token is unique
    if Device.where(access_token: new_token).count > 0
      self.new_access_token
    else
      return new_token
    end
  end
end