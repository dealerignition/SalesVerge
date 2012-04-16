class UsersController < ApplicationController
  layout false
  load_and_authorize_resource

  def new
    @user = User.new
  end

  # This will always be AJAX
  def create
    @user = User.new(params[:user])
    @user.role = "salesrep"
    @user.dealer = current_user.dealer

    if @user.save
      data = {
        :success => true,
        :data => render_to_string(:partial => "users/user", 
                                  :locals => { :user => @user })
      }

      @user = User.new
      data.merge!({ 
        :form => render_to_string(:partial => "users/form")
      })
      flash[:notice] = "User was successfully created."
      redirect_to :back
    else
      render :json => {
        :success => false,
        :form => render_to_string(:partial => "users/form")
      }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User was successfully updated."
      redirect_to :back
    else
      redirect_to :back
    end
  end
end
