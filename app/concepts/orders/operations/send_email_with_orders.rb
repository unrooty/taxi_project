class Order::SendEmailWithOrders < Trailblazer::Operation
  step Policy::Pundit(OrdersPolicy, :access_to_report_granted?)
  step :find_all_orders
  step :send_mail

  private

  def find_all_orders(options, params, *)
    options[:model] = params[:current_user].orders
  end

  def send_mail(options, params, *)
    UserMailer.send_email_with_orders(params[:current_user],
                                      options[:model]).deliver
  end
end
