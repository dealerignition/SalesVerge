class DealersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :detatch_logo
  layout "session"

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
      flash[:notice] = "Account settings saved."
    end
    redirect_to :back
  end
  
  def detatch_logo
    @dealer = Dealer.find(params[:dealer_id])
    authorize! :update, @dealer
    @dealer.logo = nil
    if @dealer.save
      flash[:notice] = "Logo has been removed."
    end
    redirect_to account_settings_dealer_path
  end

end
