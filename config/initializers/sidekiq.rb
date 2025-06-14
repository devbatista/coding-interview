require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  schedule = {
    'report_generation_job' => {
      'class' => 'ReportGenerationJob',
      'cron' => '0 * * * *'
    }
  }

  Sidekiq::Cron::Job.load_from_hash(schedule)
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Rails.application.configure do
  config.active_job.queue_adapter = :sidekiq
end