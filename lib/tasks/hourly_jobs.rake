desc "Hourly jobs"
  task :hourly_jobs => :environment do
    
    puts "About to send long_checkout_notification"
    SampleCheckout.send_long_checkout_notification
    puts "long_checkout_notification sent!"
  
  end