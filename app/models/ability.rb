class Ability
  include CanCan::Ability

  def initialize(user)
    @models = [Customer, Quote, Sample, SampleCheckout, Appointment]
    if user and user.admin?
      can :manage, :all
    elsif user and user.owner?
      cannot :manage, :all

      can :update, Dealer, :id => user.dealer.id
      can :manage, User, :dealer_id => user.dealer.id
      can :manage, Charge, :quote => { :user => { :dealer_id => user.dealer.id } }
      can :manage, @models, :user => { :dealer_id => user.dealer.id }
      can :create, [User] + @models
    elsif user and user.salesrep?
      cannot :manage, :all

      can :manage, User, :id => user.id
      can :manage, Charge, :quote => { :user_id => user.id }
      can :manage, @models, :user_id => user.id
      can :create, @models
    else
      cannot :manage, :all

      can :create, Dealer
      can :create, User
    end
  end
end
