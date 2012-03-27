class DealersController < ApplicationController
  def new
    @dealer = Dealer.new
    @user = User.new
  end

  def create
    @dealer = Dealer.new(params[:dealer])
    @user = User.new(params[:user])
    @user.role = "owner"

    if @user.valid? and @dealer.valid?
      @dealer.save
      @user.dealer = @dealer
      @user.save

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
