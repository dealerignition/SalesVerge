class AboutController < ApplicationController
  skip_authorization_check
  
  def index
    redirect_to "http://www.salesverge.com", :status => 301
  end
  
  def mobile_infographic
  end

end
