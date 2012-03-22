class DealersController < ApplicationController
  def new
    @dealer = Dealer.new
  end

  def create
    @dealer = Dealer.new(params[:dealer])
    if @dealer.save
      redirect_to root_url
      flash[:notice] = "Dealer created!"
    else
      redirect_to root_url
    end
  end

  def update
    @dealer = Dealer.find(params[:id])
    if @dealer.update_attributes(params[:dealer])
      flash[:notice] = "Dealer was successfully updated."
      redirect_to :back
    else
      redirect_to :back
    end
  end
end
