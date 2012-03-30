class DealersController < ApplicationController
  load_and_authorize_resource

  def new
    @dealer = Dealer.new
    @user = User.new
  end

  # Signing Up
  def create
    @dealer = Dealer.new(params[:dealer])
    @user = User.new(params[:user])
    @store = Store.new
    @user.role = "owner"

    if @user.valid? and @dealer.valid?
      @dealer.save
      @user.dealer = @dealer
      @user.save
      
      @store.dealer_id = @dealer.id
      @store.save

      flash[:notice] = "Account was successfully created! Welcome to your new dashboard."
      auto_login(@user)
      remember_me!
      redirect_to dashboard_path
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
