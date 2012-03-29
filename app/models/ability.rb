class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.admin?
      can :manage, :all
    elsif user and user.owner?
      cannot :manage, :all

      can :update, Dealer, :id => user.dealer.id
      can :manage, User, :dealer_id => user.dealer.id
      can :manage, [Customer, Quote, Sample, SampleCheckout, Appointment], :user => { :dealer_id => user.dealer.id }
      can :create, [User, Quote, Customer, Sample, SampleCheckout, Appointment]
    elsif user and user.salesrep?
      cannot :manage, :all

      can :manage, User, :id => user.id
      can :manage, [Customer, Quote, Sample, SampleCheckout, Appointment], :user_id => user.id
      can :create, [Quote, Customer, Sample, SampleCheckout, Appointment]
    else
      cannot :manage, :all

      can :create, Dealer
      can :create, User
    end
  end
end
