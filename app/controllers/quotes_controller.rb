class QuotesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  
  def index
    @quotes = Quote.order("created_at DESC").all
  end
  
  def show
    @quote = Quote.find(params[:id])
    @charge = Charge.new
  end
  
  def new
    @quote = Quote.new
    @customers = Customer.all
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      flash[:notice] = "Quote was successfully created."
      redirect_to quote_path(@quote)
    else
      render :action => "new"
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
    @customers = Customer.all
  end
  
  def update
    @quote = Quote.find(params[:id])
    if @quote.update_attributes(params[:quote])
      flash[:notice] = "Quote was successfully updated."
      redirect_to quote_path(@quote)
    else
      redirect_to :back
    end
  end
  
  def deliver_customer_mailer
    @estimate = Quote.find(params[:quote_id])
    CustomerMailer.estimate(@estimate).deliver
    flash[:notice] = "Estimate was sucessfully sent."
    redirect_to :back
  end
  
end
