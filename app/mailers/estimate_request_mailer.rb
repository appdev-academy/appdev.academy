class EstimateRequestMailer < ApplicationMailer
  # Send email to Customer to notify about submitting his Estimate Request
  def notify_customer(estimate_request)
    @estimate_request = estimate_request
    mail to: @estimate_request.email, subject: 'Thank you for submitting your project!'
  end
end
