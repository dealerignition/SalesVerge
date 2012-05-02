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
    else
      data = {
        :success => false
      }
    end

    data.merge!({
      :form => render_to_string(:partial => "users/form")
    })
    render :json => data
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
  
  def update_user_and_look_up_customer
    @user = User.find(params[:current_user_id])
    @customer = Customer.find_by_id(params[:customer_id])
    @customer_extension = CustomerExtension.new(:customer_id => @customer.id)
    if @customer_extension.save and @user.update_attributes(params[:user])
      flash[:notice] = "Thanks for subscribing!"
      redirect_to :back
    else
      flash[:error] = "There was an error."
      redirect_to :back
    end
  end
  
end
