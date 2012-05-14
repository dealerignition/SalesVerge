class SamplesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  def index
    searchable_index(Sample, [:dealer_sample_id, :name])
  end

  def new
    @sample = Sample.new
    @sample_name = current_user.company.sample_name
  end

  def create
    if request.xhr?
      @sample = Sample.new({
        :name => params[:sample_name],
        :dealer_sample_id => params[:sample_id],
        :company => current_user.company
      })
      render :json => { :success => @sample.save ? true : false,
                        :id => @sample.id
                      }
    else
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

end
