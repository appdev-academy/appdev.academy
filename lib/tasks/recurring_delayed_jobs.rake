# Reschedule all recurring delayed_jobs
namespace :recurring_delayed_jobs do
  task reschedule: :environment do
    SendBeaconEmailJob.schedule!
  end
end
