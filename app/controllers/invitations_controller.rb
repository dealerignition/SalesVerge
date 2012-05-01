class InvitationsController < ApplicationController
  
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      UserMailer.invitation(@invitation, signup_url(@invitation.token)).deliver
      flash[:notice] = "Thank you, invitation sent."
      redirect_to :back
    else
      render :action => 'new'
    end
  end
  
end