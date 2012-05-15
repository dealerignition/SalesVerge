class CustomerExtensionsController < ApplicationController

  skip_authorization_check

  def new
  end

  def create
    @extension = CustomerExtension.new
    @extension.customer_id = params[:customer_id]
    if @extension.save
      redirect_to :back
    else
      flash[:error] = "There was an error."
      redirect_to :back
    end
  end

end
