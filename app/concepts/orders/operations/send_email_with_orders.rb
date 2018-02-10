class Order::SendEmailWithOrders < Trailblazer::Operation
  step Policy::Pundit(OrdersPolicy, :access_to_report_granted?)
  step :find_all_orders
  step :send_mail

  private

  def find_all_orders(options, current_user:, **)
    options[:model] = current_user.orders
  end

  def send_mail(options, current_user:, model:, **)
    UserMailer.send_email_with_orders(current_user,
                                      model).deliver
  end
end
