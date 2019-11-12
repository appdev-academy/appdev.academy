class SendBeaconEmailJob
  include Delayed::RecurringJob
  
  run_every 1.day
  run_at '06:00am'
  
  def perform
    AdminMailer.beacon.deliver_now
  end
end
