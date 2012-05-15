class UpdateInvitationsForCollaboration < ActiveRecord::Migration
  def up
    Invitation.delete_all

    add_column :invitations, :recipient_id, :integer
    add_column :invitations, :status, :string, :default => :sent
    remove_column :users, :invitation_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
