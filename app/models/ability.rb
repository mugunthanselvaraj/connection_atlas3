class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:organizer)
      can :create, Event
      can :update, Event, user_id: user.id
      can :read, Event
    elsif user.has_role?(:companion)
      can :read, Event
      can :update, User, id: user.id
    else # Default participant
      can :read, Event
    end
  end
end
