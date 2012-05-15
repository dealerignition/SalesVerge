class Invitation < ActiveRecord::Base
  STATUSES = %w(sent accepted rejected)

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validates_presence_of :recipient_email
  validates_presence_of :sender_id
  validates_presence_of :status
  validates_inclusion_of :status, :in => STATUSES

  validates :recipient_email, :email => { :mx => true }
  validate :email_uniqueness
  validate :owner_status

  before_create :generate_token

  private

  def email_uniqueness
    if sender.company.users.where(:email => recipient_email).exists?
      errors.add :recipient_email, "is already a member of your company"
    elsif sender.sent_invitations.where(:recipient_email => recipient_email, :status => "sent").exists?
      errors.add :recipient_email, "is already invited"
    end
  end

  def owner_status
    if recipient && recipient.salesrep?
      errors.add :recipient, "is a sales rep for another company. We don't support importing sales reps at present. Please <a href='mailto://support@dealerbookapp.com'>email us</a>."
    end
  end

  def generate_token
    self.token = Digest::MD5.hexdigest([Time.now, rand].join)
  end

end
