class OrdersPolicy

  def initialize(user, model)
    @user = user
    @model = model
  end

  def access_allowed?
    !@user.nil? && @model.user_id == @user.id
  end

  def access_to_report_allowed?
    !@user.nil?
  end
end
