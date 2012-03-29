class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.admin?
      can :manage, :all
    elsif user and user.owner?
      cannot :manage, :all

      can :update, Dealer, :id => user.dealer.id
      can :manage, User, :dealer_id => user.dealer.id
      can :manage, Customer, :user => { :dealer_id => user.dealer.id }
      can :manage, Quote, :user => { :dealer_id => user.dealer.id }
      can :create, [User, Quote, Customer]
    elsif user and user.salesrep?
      cannot :manage, :all

      can :manage, User, :id => user.id
      can :manage, Customer, :user_id => user.id
      can :manage, Quote, :user_id => user.id
      can :create, [Quote, Customer]
    else
      cannot :manage, :all

      can :create, Dealer
      can :create, User
    end
  end
end
