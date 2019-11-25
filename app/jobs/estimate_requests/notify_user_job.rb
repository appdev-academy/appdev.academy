class NotifyUserJob < ApplicationJob
  queue_as :emails
  
  def perform(estimate_request_id)
    estimate_request = EstimateRequest.find(estimate_request_id)
    UserMailer.estimate_request(estimate_request).deliver_now
  end
end
