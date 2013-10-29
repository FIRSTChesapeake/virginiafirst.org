class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:admin)
      can :manage, :all
    else
      if user.has_role?(:virginia_first)
        can :read, Event
        can :read, Game
        can :read, Role
        can :read, Profile
        can :read, User
      end

      if user.has_role?(:ftc_admin)
        can :manage, Event, program: {code: :ftc}
        can :manage, Game, program: {code: :ftc}
      end

      if user.has_role?(:frc_admin)
        can :manage, Event, program: {code: :frc}
        can :manage, Game, program: {code: :frc}
      end

      if user.has_role?(:key_volunteer)
        can :read, Volunteer::Assignment
        can :read, Event
        can :read, Volunteer::Registration
      end

      if user.has_role?(:volunteer_coordinator)
        can :manage, Volunteer::Assignment
        can :read, Event
        can :manage, Volunteer::Position
        can :read, Profile
        can :manage, Volunteer::Registration
      end
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
