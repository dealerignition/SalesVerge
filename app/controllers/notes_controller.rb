class NotesController < ApplicationController
  load_and_authorize_resource
  
  track :new, "started a new note"
  track :create, "created a new note"
  track :destroy, "deleted a note"
  
  def new
    @note = Note.new

    @customer = Customer.find(params[:customer_id])
    @user = current_user
  end

  def create
    @note = Note.new(params[:note])
    if @note.save
      flash[:notice] = "Note was successfully created."
    else
      flash[:error] = "Note was not successfully created."
    end
    redirect_to :back
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = "Note deleted."
    redirect_to :back
  end
end
