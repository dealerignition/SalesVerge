class AppRequestsController < ApplicationController
  skip_authorization_check

  def new
    @app_request = AppRequest.new
  end

  def create
    @app_request = AppRequest.new(params[:app_request])
    if @app_request.save
      AnonymousMailer.app_request(@app_request).deliver
      flash[:notice] = "Thank you!"
    else
      flash[:error] = "Please provide a valid email address."
    end
    redirect_to :back
  end
end
