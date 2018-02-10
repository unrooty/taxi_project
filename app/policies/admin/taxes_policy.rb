class Admin::TaxesPolicy
  def initialize(user, *)
    @user = user
  end

  def index?
    @user.role.in?(%w[Admin Manager Dispatcher Driver])
  end

  def can_manage?
    @user.role.in?(%w[Admin Manager])
  end
end
