class AnonymousMailer < ActionMailer::Base
  default from: "notifications@dealeronthego.com"
  
  def app_request(app_request)
    @app_request = app_request
    mail(:to => @app_request.email, :subject => "Thank you for your interest in #{@app_request.app_name}")
  end

end