class Session < ApplicationRecord
  # Relationships
  belongs_to :user
  
  # Relationships validations
  validates :user, presence: true
  
  # Fields validations
  validates :access_token, presence: true, uniqueness: true
  
  # Generates new unique access token
  def self.new_access_token
    # Generate new token
    new_token = SecureRandom.hex(16)
    
    # Call this function until new token is valid
    if Session.where(access_token: new_token).count > 0
      self.new_access_token
    else
      return new_token
    end
  end
end
