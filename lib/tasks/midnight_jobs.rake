desc "Jobs that will run at midnight."
  task :midnight_jobs => :environment do
    
    puts "About to send todays_app_requests"
    AppRequest.send_todays_app_requests
    puts "todays_app_requests sent!"
    
  end