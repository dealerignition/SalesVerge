class AnonymousMailer < ActionMailer::Base
  default from: "notifications@salesverge.com"
  
  def app_request(app_request)
    @app_request = app_request
    if @app_request.app_name == 'SalesVerge'
      @survey_link = 'https://dealerignition.wufoo.com/forms/dealeronthego-request/'
    elsif @app_request.app_name == 'FloorStoreOnTheGo'
      @survey_link = 'https://dealerignition.wufoo.com/forms/floorstoreonthego-request/'
    elsif @app_request.app_name == 'SalesUps'
      @survey_link = 'https://dealerignition.wufoo.com/forms/salesups-request/'
    end
    mail(:to => @app_request.email, :subject => "Thank you for your interest in #{@app_request.app_name}")
  end
  
  def app_invite(app_request)
    @app_request = app_request
    if @app_request.app_name == 'SalesVerge'
      @survey_link = 'https://dealerignition.wufoo.com/forms/dealeronthego-request/'
    elsif @app_request.app_name == 'FloorStoreOnTheGo'
      @survey_link = 'https://dealerignition.wufoo.com/forms/floorstoreonthego-request/'
    elsif @app_request.app_name == 'SalesUps'
      @survey_link = 'https://dealerignition.wufoo.com/forms/salesups-request/'
    end
    mail(:to => @app_request.email, :subject => "Here is your invitiation to join #{@app_request.app_name}")
  end

end