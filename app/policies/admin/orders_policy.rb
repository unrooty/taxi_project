class Admin::OrdersPolicy
  def initialize(user, *)
    @user = user
  end

  def can_work_with_order?
    @user.role.in?(%w[Admin Manager Dispatcher Driver])
  end
end
