class ChargesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active

  def new
    @quote = Quote.find(params[:quote_id])
    @charge = Charge.new
  end
  
  def create
    @charge = Charge.new(params[:charge], :date => Time.now)
    if @charge.save
      flash[:notice] = "Charge was successfully created."
      redirect_to :back
    else
      flash[:error] = "Charge was not successfully created. Please try again."
      redirect_to :back
    end
  end

  def edit
    @charge = Charge.find_by_id(params[:id])
  end
  
  def destroy
    @charge = Charge.find(params[:id])
    @quote = Quote.find(params[:quote_id])
    @charge.destroy

    flash[:notice] = "Charge deleted."
    redirect_to quote_path(@quote)
  end

end
