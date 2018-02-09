class Admin::AffiliatesPolicy
  def initialize(user, *)
    @user = user
  end

  def user_admin?
    @user.role == :administrator
  end
end

