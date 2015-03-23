class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    can :manage, Order, user_id: user.id
    can :manage, OrderServing do |serving|
      serving.order.user_id == user.id
    end
    can :manage, OrderPortion do |portion|
      portion.order.user_id == user.id
    end
    can :manage, ShoppingCart, user_id: user.id

    can [:read, :search], Recipe, published: true
    if user.is? :admin
      can :manage, :all
      can :export, Order

    elsif user.is? :mechanical_turk
      can :manage, Product

    elsif !user.guest?
      can :manage, Billing, user_id: user.id
      can :read, :dashboard
      can :read, :settings
      can :read, :pricing
      can :manage, Subscription
    end
  end
end
