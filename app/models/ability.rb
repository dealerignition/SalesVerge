class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.owner?
      can :manage, Customer, :user => { :dealer_id => user.dealer.id }
    elsif user.salesrep?
      can :manage, Customer, :user_id => user.id
    else
    end
  end
end
