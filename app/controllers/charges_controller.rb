class ChargesController < ApplicationController
  before_filter :require_login

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
      redirect_to(edit_quote_path(@quote), :notice => 'Charge was successfully created.')
    else
      render :action => "new"
    end
  end

end
