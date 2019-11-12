class EstimateRequest < ApplicationRecord
  # Constants
  EMAIL_FORMAT = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  # Uploaders
  mount_uploader :document, DocumentUploader
  
  # Field validations
  validates :name, presence: true
  validates :document, file_size: { less_than_or_equal_to: 500.kilobytes }, file_content_type: { allow: ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'], message: 'Only *.xlsx files are allowed' }, if: :document?
  validates :email, presence: true, format: { with: EMAIL_FORMAT, message: "address format is incorrect." }
  validates :subject, presence: true
  validates :budget, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :details, presence: true
end
