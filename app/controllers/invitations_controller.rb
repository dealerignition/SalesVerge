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
      flash[:notice] = "Invitation sent to #{@invitation.recipient_email}."
    else
      flash[:error] = "Invitation could not be sent."
    end
    redirect_to :back
  end
  
end