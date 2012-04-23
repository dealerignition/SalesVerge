class QuotesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  def show
    @quote = Quote.find(params[:id])
    @charge = Charge.new
  end

  def new
    @quote = Quote.new

    if params[:customer_id] and @customer = Customer.find(params[:customer_id]) and can? :read, @customer
      @quote.customer = @customer
      @quote.user = current_user
      @quote.save
      redirect_to @quote
    end

    @customers = Customer.accessible_by(current_ability)
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
    @customers = Customer.accessible_by(current_ability)
  end

  def update
    @quote = Quote.find(params[:id])

    if @quote.update_attributes(params[:quote])
      flash[:notice] = "Quote was successfully updated."
    end

    redirect_to :back
  end

  def won
    @quote = Quote.find(params[:quote_id])
    @quote.status = "won"

    if @quote.save
      CustomerMailer.quote_won(@quote).deliver
      flash[:notice] = "Quote was successfully updated."
    end

    redirect_to :back
  end

  def lost
    @quote = Quote.find(params[:quote_id])
    @quote.status = "lost"
    flash[:notice] = "Quote was successfully updated." if @quote.save

    redirect_to :back
  end

  def deliver_customer_mailer
    @quote = Quote.find(params[:quote_id])
    CustomerMailer.quote(@quote).deliver
    flash[:notice] = "Quote was sucessfully sent to #{@quote.customer.email}."

    redirect_to :back
  end

end
