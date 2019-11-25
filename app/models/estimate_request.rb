class EstimateRequest < ApplicationRecord
  # Constants
  EMAIL_FORMAT = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  # Callbacks
  after_save :notify_admin
  
  # Uploaders
  mount_uploader :document, DocumentUploader
  
  # Field validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: EMAIL_FORMAT, message: "address format is incorrect." }
  validates :subject, presence: true
  validates :budget, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :details, presence: true
  
  private
    def notify_admin
      NotifyAdminJob.perform_later(self)
    end
end
