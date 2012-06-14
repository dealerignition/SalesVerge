class AdminMailer < ActionMailer::Base
  default from: "notifications@dealeronthego.com"

  def app_request(app_request)
    @app_request = app_request
    mail(:to => "support@dealerignition.com", :subject => "Invite request for #{@app_request.app_name}")
  end
  
end
