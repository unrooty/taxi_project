# Form object for assign car
class AssignedCar
  include ActiveModel::Model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor(
    :car_id,
    :order_id
  )

  def persisted?
    false
  end

  validates :car_id, presence: true

  def save
    order = Order.find(order_id)
    car = Car.find(car_id)
    if order.car_id.nil? && car.car_status != 'ordered'
      order.car_id = car_id
      car.update(car_status: 1)
      order.update(order_status: 1)
      0
    elsif order.car_id.nil? && car.car_status == 'ordered'
      1
    elsif order.car_id && car.car_status != 'ordered'
      2
    end
  end

  def send_letter
    order = Order.find(order_id)
    if order.user_id
      car = Car.find(car_id)
      user = User.find(order.user_id)
      UserMailer.delay.car_assignment_mail(user, car)
    else
      true
    end
  end
end
