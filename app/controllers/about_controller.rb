class AboutController < ApplicationController
  skip_authorization_check
  
  def index
  end
  
  def salesverge
    @request = AppRequest.new
    @app_name = "SalesVerge"
  end
  
  def floorstoreonthego
    @request = AppRequest.new
    @app_name = "FloorStoreOnTheGo"
  end
  
  def salesups
    @request = AppRequest.new
    @app_name = "SalesUps"
  end

end
