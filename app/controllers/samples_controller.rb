class SamplesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  def index
    searchable_index(Sample, [:dealer_sample_id, :name])
  end

  def new
    @sample = Sample.new
    @sample_name = current_user.dealer.sample_name
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
