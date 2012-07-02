class AdminMailer < ActionMailer::Base
  default from: "notifications@salesverge.com"

  def app_request(app_request)
    @app_request = app_request
    mail(:to => "support@salesverge.com", :subject => "Invite request for #{@app_request.app_name}")
  end
  
end
