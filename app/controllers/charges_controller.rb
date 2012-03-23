class ChargesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active

  def new
    @quote = Quote.find(params[:quote_id])
    @charge = Charge.new
  end

  def edit
    @charge = Charge.find_by_id(params[:id])
  end
  
  def create
    @quote = Quote.find(params[:quote_id])
    @charge = Charge.new(params[:charge], :date => Time.now)
    if @charge.save
      redirect_to(quote_path(@quote), :notice => 'Charge was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def destroy
    @charge = Charge.find(params[:id])
    @quote = Quote.find(params[:quote_id])
    @charge.destroy

    flash[:notice] = "Charge delete."
    redirect_to quote_path(@quote)
  end

end
