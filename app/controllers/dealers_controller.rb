class DealersController < ApplicationController
  def new
    @dealer = Dealer.new
  end

  def create
    @dealer = Dealer.new(params[:dealer])
    if @dealer.save
      flash[:notice] = "Account was successfully created! You may now login with the email address #{@dealer.users.first.email}."
      redirect_to login_path
    else
      render :new
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
