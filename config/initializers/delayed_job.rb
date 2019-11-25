Delayed::Worker.default_queue_name = 'main'
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.max_attempts = 5
Delayed::Worker.max_run_time = 3.hours
Delayed::Worker.queue_attributes = {
  emails: { priority: 10 },
  main: { priority: 10 },
  recurring: { priority: 10 }
}
