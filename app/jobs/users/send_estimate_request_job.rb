class SendEstimateRequestJob < ApplicationJob
  queue_as :emails
  
  def perform(estimate_request)
    AdminMailer.estimate_request(estimate_request).deliver_now
  end
end
