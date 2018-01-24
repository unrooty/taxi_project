# CanCanCan abilities class
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.manager?
      can :manage, Order
      can :manage, User
      can :manage, Car
      can :manage, Invoice
      can %i[new create], Billing
      can %i[new create], AssignedCar
      can :read, :all
    elsif user.driver?
      can :create, Order
      can %i[new create], Billing
      can %i[new create], AssignedCar
      can :update, Order
      can :create, Invoice
      can :driver_orders_index, Order
      can :update, Invoice do
        order.user == current_user
      end
      can :feedback_mail, HomeController
      can :read, :all
    elsif user.dispatcher?
      can %i[new create], Billing
      can %i[new create], AssignedCar
      can %i[new create edit update], Invoice
      can :manage, Order
      can :read, User
    elsif user.accountant?
      can :read, :all
    elsif user.client?
      can :generate_orders_pdf, Object
      can :send_orders_mail, Order
      can :create, Order
      can :update, Order
      can :destroy, Order
      cannot %i[new create], Billing
      cannot %i[new create], AssignedCar
      can :read, Order
    else
      can :read, [Affiliate, Invoice]
      can :feedback_mail, HomeController
      can :create, Order
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
