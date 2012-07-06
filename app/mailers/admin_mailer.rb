class AdminMailer < ActionMailer::Base
  default from: "notifications@salesverge.com"

  def todays_app_requests(todays_app_requests)
    @todays_app_requests = todays_app_requests
    mail(:to => "support@salesverge.com", :subject => "Daily invite requests in the last 24 hours")
  end
  
end
