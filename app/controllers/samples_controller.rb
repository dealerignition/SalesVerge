class SamplesController < ApplicationController
  
  def index
    @samples = Sample.all
  end
  
  def new
    @sample = Sample.new
  end
  
  def create
    @sample = Sample.new(params[:sample])
    if @sample.save
      redirect_to(sample_checkouts_path, :notice => 'Sample was successfully created.')
    else
      render :action => "new"
    end
  end
  
end
