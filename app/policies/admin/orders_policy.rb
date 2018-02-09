class Admin::OrdersPolicy
  def initialize(user, *)
    @user = user
  end

  def can_work_with_order?
    @user.role.in?(%i[administrator manager driver dispatcher])
  end
end
