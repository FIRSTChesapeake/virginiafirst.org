class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:admin)
      can :manage, :all
    else
      if user.has_role?(:virginia_first)
        can :read, Event
        can :read, Game
        can :read, Skill
        can :read, Role
        can :read, Profile
        can :read, User
      end

      if user.has_role?(:ftc_admin)
        can :manage, Event, program: {code: :ftc}
        can :read, Event
        can :manage, Game, program: {code: :ftc}
        can :manage, Role
      end

      if user.has_role?(:frc_admin)
        can :manage, Event, program: {code: :frc}
        can :read, Event
        can :manage, Game, program: {code: :frc}
        can :manage, Role
      end

      if user.has_role?(:fll_admin)
        can :manage, Event, program: {code: :fll}
        can :read, Event
        can :manage, Game, program: {code: :fll}
        can :manage, Role
      end
    end
  end

end


