class AdminMailer < ApplicationMailer
  before_action :set_admin_email
  
  # Send email to admin to notify that Delayed::Job is still working
  def beacon
    mail to: @admin_email, subject: 'App Dev Academy is operating normally!'
  end
  
  # Send email to admin to notify about new Estimate Request
  def estimate_request(estimate_request)
    @estimate_request = estimate_request
    mail to: @admin_email, subject: 'New Estimate Request!'
  end
  
  private
    def set_admin_email
      @admin_email = 'maksym@appdev.academy'
    end
end
