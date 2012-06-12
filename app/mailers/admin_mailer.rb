class AdminMailer < ActionMailer::Base
  default from: "notifications@dealeronthego.com"

  def app_request(app_request)
    @app_request = app_request
    mail(:to => "demo@dealeronthego.com", :subject => "Someone requested an invite")
  end
  
end
