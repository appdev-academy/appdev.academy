class AdminMailer < ApplicationMailer
  before_action :set_admin_email
  
  # Send email to admin to notify that Delayed::Job is still working
  def beacon
    mail to: @admin_email, subject: 'AppDev Academy is operating normally!'
  end
  
  private
    def set_admin_email
      @admin_email = 'maksym@appdev.academy'
    end
end
