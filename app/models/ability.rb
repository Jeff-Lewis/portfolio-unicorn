class Ability
  include CanCan::Ability

  def initialize(user)
    #User can only read the Exchanges and Securities
    can :read, [Exchange, Security]

    #User can do everything on what they own
    can :manage, User, id: user.id
    can :manage, Portfolio, user_id: user.id
    can :read, Position, portfolio: { user_id: user.id }
  end
end
