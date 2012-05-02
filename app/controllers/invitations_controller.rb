class InvitationsController < ApplicationController
  layout false
  skip_authorization_check
  
  def new
    @invitation = Invitation.new
    @user = User.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      UserMailer.invitation(@invitation).deliver
      flash[:notice] = "Thank you, invitation sent."
      redirect_to :back
    else
      render :action => 'new'
    end
  end
  
end