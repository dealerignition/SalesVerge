class CompaniesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :detatch_logo
  layout "session"

  def new
    @company = Company.new
    @user = User.new
  end

  # Signing Up
  def create
    @company = Company.new(params[:company])
    @user = User.new(params[:user])
    @user.role = "user"

    if @user.valid? and @company.valid?
      @user.save
      @company.save
      CompanyUser.create(
        :company => @company,
        :user => @user,
        :role => :owner
      )

      auto_login(@user)
      remember_me!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Account settings saved."
    end
    redirect_to :back
  end

  def detatch_logo
    @company = Company.find(params[:company_id])

    authorize! :update, @company
    @company.logo = nil
    if @company.save
      flash[:notice] = "Logo has been removed."
    end
    redirect_to account_settings_company_path
  end

end
