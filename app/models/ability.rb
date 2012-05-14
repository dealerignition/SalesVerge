class Ability
  include CanCan::Ability

  def initialize(user)
    @models = [Customer, Quote, SampleCheckout, Appointment, Note]

    # Cannot do anything by default
    cannot :manage, :all

    if user
      case user.role
      when "admin"
        can :manage, :all
      when "user"
        role = user.company_users.find_by_company_id(user.company).role

        # Has control of own user.
        can :manage, User, :id => user.id

        # Has control of samples for the whole company.
        can :manage, Sample, :company_id => user.company.id

        # Can create anything.
        can :create, @models

        case role
        when "owner"
          # Can update the information for the company.
          can :update, Company, :id => user.company.id

          # Can manage charges for company's quotes.
          can :manage, Charge, :quote => { :user_id => user.company.users.pluck("users.id") }

          # Can manage all the whole company.
          can :manage, @models, :user_id => user.company.users.pluck("users.id")
        when "salesrep"
          # Can modify charges for own quotes.
          can :manage, Charge, :quote => { :user_id => user.id }
          # Can view charges for the whole company's quotes.
          can :read, Charge, :quote => { :user_id => user.company.users.pluck("users.id") }

          # Can read all the company information.
          can :read, @models, :user_id => user.company.users.pluck("users.id")
          # Can manage own information.
          can :manage, @models, :user_id => user.id

          # Can manage company checkouts.
          can :manage, SampleCheckout, :user_id => user.company.users.pluck("users.id")
        end
      end
    else
      # Not logged in

      can :create, [Company, User]
    end
  end
end
