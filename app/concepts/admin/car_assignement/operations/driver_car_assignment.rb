module Admin::CarAssignment
  class DriverCarAssignment < Trailblazer::Operation
    extend DriverCarAssignment::Contract::DSL
    step Model(OpenStruct, :new)
    step :find_car
    step :find_order
    step :create_car_assignment_params
    step self::Contract::Build()
    step self::Contract::Validate(key: :car_assignment)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction(&block) } {
      step :update_car_status_if_car_not_ordered
      step :update_order_status_if_order_has_no_car
      step :assign_car_to_order
      step :send_car_assignment_email_to_user
    }
    def find_car(options, *)
      @car = options['current_user'].car
    end

    def find_order(options, *)
      @order = Order.find(options['params']['order_id'])
    end

    def create_car_assignment_params(_options, params:, **)
      params[:car_assignment] = { car_id: @car.id, car_status: @car.car_status,
                                  order_id: @order.id }
    end

    def update_car_status_if_car_not_ordered(*)
      @car.update(car_status: 1)
    end

    def update_order_status_if_order_has_no_car(*)
      @order.update(order_status: 1)
    end

    def assign_car_to_order(*)
      @order.update(car_id: @car.id)
    end

    def send_car_assignment_email_to_user(*)
      UserMailer.car_assignment_mail(@order.user, @car) if @order.user_id

      true
    end
  end
end
