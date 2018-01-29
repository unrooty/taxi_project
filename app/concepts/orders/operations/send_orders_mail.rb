class Order::SendOrdersMail < Trailblazer::Operation
  step :find_all_orders!
  step :send_mail!

  private

  def find_all_orders(options, params, *)
    options['model'] = params['current_user'].orders.all
  end

  def send_mail(options, params, *)
    UserMailer.send_orders_mail(params['current_user'],
                                options['model']).deliver
  end
end
