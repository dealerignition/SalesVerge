class AboutController < ApplicationController
  skip_authorization_check
  
  def index
  end
  
  def dealeronthego
    @request = AppRequest.new
  end

end
