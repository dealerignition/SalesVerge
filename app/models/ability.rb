class Ability
  include CanCan::Ability

  def initialize(user)
    @models = [Customer, Estimate, SampleCheckout, Appointment, Note]
    if user and user.admin?
      can :manage, :all
    elsif user and user.owner?
      cannot :manage, :all

      can :update, Dealer, :id => user.dealer.id
      can :manage, User, :dealer_id => user.dealer.id
      can :manage, Charge, :estimate => { :user => { :dealer_id => user.dealer.id } }
      can :manage, @models, :user => { :dealer_id => user.dealer.id }
      can :manage, Sample, :store => { :dealer_id => user.dealer.id }
      can :manage, Note, :note => { :dealer_id => user.dealer.id }
      can :create, [User, Sample, Note] + @models
    elsif user and user.salesrep?
      cannot :manage, :all

      can :manage, User, :id => user.id
      can :manage, Charge, :estimate => { :user_id => user.id }
      can :manage, Sample, :store => { :dealer_id => user.dealer.id }
      can :manage, @models, :user_id => user.id
      can :manage, Note, :note => { :dealer_id => user.dealer.id }
      can :create, [Sample, Note] + @models
    else
      cannot :manage, :all

      can :create, Dealer
      can :create, User
    end
  end
end
