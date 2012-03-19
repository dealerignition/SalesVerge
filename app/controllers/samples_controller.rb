class SamplesController < ApplicationController
  before_filter :require_login
  
  def index
    @samples = Sample.all
  end
  
  def new
    @sample = Sample.new
  end
  
  def create
    @sample = Sample.new(params[:sample])
    if @sample.save
      redirect_to :back
      flash[:notice] = "Sample was successfully created."
    else
      render :action => "new"
    end
  end
  
end
