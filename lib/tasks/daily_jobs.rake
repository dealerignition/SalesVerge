desc "Daily jobs-Typically email summaries."
  task :daily_jobs => :environment do

    puts "About to send daily_digest"
    User.send_daily_digest
    puts "daily_digest sent!"
    
    puts "About to send long_checkout_notification"
    SampleCheckoutSet.send_long_checkout_set_notification
    puts "long_checkout_notification sent!"
    
    puts "About to send low_activity_mailer"
    User.send_low_activity_mailer
    puts "low_activity_mailer sent!"
  
  end