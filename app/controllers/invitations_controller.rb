class InvitationsController < ApplicationController
  before_filter :require_login, :only => [:connect, :accept, :reject]
  layout "session"
  skip_authorization_check
  
  track :new, "started a new invitation"
  track :create, "created a new invitation"

  def new
    @invitation = Invitation.new
    @user = User.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user

    @user = User.find_by_email(@invitation.recipient_email)
    if @user
      # This user exists.
      @invitation.recipient = @user
    end

    unless @invitation.save
      errors = "Invitation could not be sent.<ul>"
      @invitation.errors.full_messages.each do |msg|
        errors << "<li>#{msg}</li>"
      end
      errors << "</ul>"
      flash[:error] = errors.html_safe
    else
      if @invitation.recipient
        UserMailer.connection_invitation(@invitation).deliver
      else
        UserMailer.invitation(@invitation).deliver
      end
      flash[:notice] = "Invitation sent to #{@invitation.recipient_email}."
    end

    redirect_to :back

  end

  def connect
    @invitation = Invitation.find_by_token params[:invitation_token]
    auto_login(@invitation.recipient)
  end

  def accept
    @invitation = Invitation.find params[:invitation_id]
    authorize! :update, @invitation

    @invitation.recipient.company_users.delete_all
    @invitation.recipient.company_users.create(
      :company => @invitation.sender.company,
      :role => "salesrep"
    )

    @invitation.update_attribute :status, :accepted
    flash[:notice] = "You accepted #{ @invitation.sender.full_name}'s invitation. You are now a member of #{ current_user.company.name }. All your infomation has been ported."

    redirect_to :dashboard
  end

  def reject
    @invitation = Invitation.find params[:invitation_id]
    authorize! :update, @invitation

    @invitation.update_attribute :status, :rejected
    flash[:notice] = "You rejected #{ @invitation.sender.full_name}'s invitation."

    redirect_to :dashboard
  end
end
