class Admin::CarsPolicy
  def initialize(user, *)
    @user = user
  end

  def can_work_with_car?
    @user.role.in?(%w[Admin Manager])
  end
end
