desc "Daily jobs-Typically email summaries."
  task :daily_jobs => :environment do
    
    puts "About to send daily_digest"
    puts User.send_daily_digest
    puts "daily_digest sent!"
  
  end