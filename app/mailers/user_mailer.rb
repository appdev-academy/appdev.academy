class UserMailer < ApplicationMailer
  # Send email to User to notify about submitting his Estimate Request
  def estimate_request(estimate_request)
    @estimate_request = estimate_request
    mail to: @estimate_request.email, subject: 'Thank you for submitting your project!'
  end
end
