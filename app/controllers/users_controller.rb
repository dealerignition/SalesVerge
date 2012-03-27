class UsersController < ApplicationController
  layout false

  def new
    @user = User.new
  end

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

      render :json => data
    else
      render :json => {
        :success => false,
        :form => render_to_string(:partial => "users/form", 
                                  :locals => { :user => @user })
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
