class QuotesController < ApplicationController
  def index
    @quotes = Quote.order("created_at DESC").all
  end
  
  def new
    @quote = Quote.new
    @customers = Customer.all
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      redirect_to edit_quote_path(@quote)
      flash[:notice] = "Post was successfully created."
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
      redirect_to quotes_path
      flash[:notice] = "Quote was successfully update."
    else
      redirect_to edit_customer_path(@quote)
    end
  end
end
