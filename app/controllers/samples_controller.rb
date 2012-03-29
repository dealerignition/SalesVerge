class SamplesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource
  
  def index
    @samples = Sample.accessible_by(current_ability)
  end
  
  def new
    @sample = Sample.new
  end
  
  def create
    @sample = Sample.new(params[:sample])
    if @sample.save
      flash[:notice] = "#{@sample.name} was successfully created."
      redirect_to :back
    else
      flash[:error] = "Sample was not successfully created."
      redirect_to :back
    end
  end
  
end
