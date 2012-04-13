class EstimatesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  def index
    @estimates = Estimate.accessible_by(current_ability).order("created_at DESC").find_all_by_status(nil)
    @ended_estimates = Estimate.accessible_by(current_ability).order("created_at DESC").where("status IS NOT null").all
  end

  def show
    @estimate = Estimate.find(params[:id])
    @charge = Charge.new
  end

  def new
    @estimate = Estimate.new

    if params[:customer_id] and @customer = Customer.find(params[:customer_id]) and can? :read, @customer
      @estimate.customer = @customer
      @estimate.user = current_user
      @estimate.save
      redirect_to @estimate
    end

    @customers = Customer.accessible_by(current_ability)
  end

  def create
    @estimate = Estimate.new(params[:estimate])

    if @estimate.save
      flash[:notice] = "Estimate was successfully created."
      redirect_to estimate_path(@estimate)
    else
      render :action => "new"
    end
  end

  def edit
    @estimate = Estimate.find(params[:id])
    @customers = Customer.accessible_by(current_ability)
  end

  def update
    @estimate = Estimate.find(params[:id])

    if @estimate.update_attributes(params[:estimate])
      flash[:notice] = "Estimate was successfully updated."
    end

    redirect_to :back
  end

  def won
    @estimate = Estimate.find(params[:estimate_id])
    @estimate.status = "won"

    if @estimate.save
      CustomerMailer.estimate_won(@estimate).deliver
      flash[:notice] = "Estimate was successfully updated."
    end

    redirect_to :back
  end

  def lost
    @estimate = Estimate.find(params[:estimate_id])
    @estimate.status = "lost"
    flash[:notice] = "Estimate was successfully updated." if @estimate.save

    redirect_to :back
  end

  def deliver_customer_mailer
    @estimate = Estimate.find(params[:estimate_id])
    CustomerMailer.estimate(@estimate).deliver
    flash[:notice] = "Estimate was sucessfully sent to #{@estimate.customer.email}."

    redirect_to :back
  end

end
