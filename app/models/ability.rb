class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.admin?
      can :manage, :all
    elsif user and user.owner?
      can :manage, Customer, :user => { :dealer_id => user.dealer.id }
      can :manage, User, :dealer_id => user.dealer.id
    elsif user and user.salesrep?
      can :manage, Customer, :user_id => user.id
      can :manage, User, :id => user.id
    else
      can :create, User
    end
  end
end
