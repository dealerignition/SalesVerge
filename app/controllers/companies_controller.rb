class CompaniesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:detatch_logo, :set_wants_website_scraped]
  layout "session"
  layout "main", :only => :edit

  def new
    @company = Company.new
    @user = User.new
  end
  
  def edit
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
        :role => "owner"
      )
      UserMailer.welcome_email(@user).deliver
      auto_login(@user)
      remember_me!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    @company = Company.find(params[:id])
    if params[:company][:file] == nil
      if @company.update_attributes(params[:company])
        flash[:notice] = "Account settings saved."
      end
    else 
      if upload_products(params[:company][:file])
        flash[:notice] = "Products saved successfully."
      else
        flash[:error] = "An error occurred while saving your products. Are you sure your file is in the correct format?"
      end
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
    redirect_to settings_company_path
  end
  
  def set_wants_website_scraped
    @company = Company.find(params[:company_id])
    authorize! :update, @company
    @company.wants_website_scraped = true
    if @company.save
      flash[:notice] = "Thank you for submitting your website. We will get our gnomes working on it within 24 hours."
    end
    redirect_to settings_company_path
  end

  def upload_products(file)
    begin
      CSV.foreach(file.tempfile, {:headers=>true}) do |row|
        s = Sample.new
        s.dealer_sample_id = row["SKU#"]
        s.name = row["Name"]
        s.company = @company
        s.description = row["Description"]
        s.price = row["Price"]
        s.url = row["URL"]
        s.creator = "CSV"
        s.save!
      end
    rescue => e
      logger.error e
      return false
    end
    true
  end

end
