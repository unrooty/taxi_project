# Form object for create invoice
class Billing
  include ActiveModel::Model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor(
    :distance,
    :order_id,
    :invoice_status,
    :payed_amount,
    :indebtedness
  )

  validates :payed_amount, presence: true,
                           numericality: { greater_than_or_equal_to: 0 }
  validates :distance, presence: true,
                       numericality: { greater_than_or_equal_to: 0 }

  def save
    if payed_amount.to_f > 0 && distance.to_f > 0
      invoice = Invoice.create(distance: distance,
                               total_price: total,
                               payed_amount: payed_amount,
                               invoice_status: set_invoice_status[0],
                               indebtedness: set_invoice_status[1],
                               order_id: order_id)
      invoice.order.update(order_status: 2)
      Car.find(Order.find(order_id).car_id).update(car_status: 0)
      if invoice.order.user_id
        user = User.find(Order.find(invoice.order_id).user_id)
        UserMailer.delay(run_at: 45.seconds.from_now).invoice_report_mail(user,
                                                                          invoice)
      else
        true
      end
    end
  end

  def total
    @tax = Order.find(order_id).tax
    distance.to_f * @tax.cost_per_km.to_f + @tax.basic_cost.to_f
  end

  def set_invoice_status
    if total > payed_amount.to_f && payed_amount.to_f != 0
      [2, total - payed_amount.to_f]
    elsif payed_amount.zero?
      [1, total]
    else
      [0, 0]
    end
  end
end
