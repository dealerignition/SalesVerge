desc "Hourly jobs"
  task :hourly_jobs => :environment do
    ScrapyJob.run
  end