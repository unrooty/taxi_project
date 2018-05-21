
module Admin::CarAssignment
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(OpenStruct, :new)
      step self::Contract::Build(constant:
                                     Admin::CarAssignment::Contract::Create)
    end

    step Nested(Present)
    step :add_order_id_to_car_assignment_params
    step self::Contract::Validate(key: :car_assignment)
    step Wrap(SequelTransaction) {
      step :find_car
      step :find_order
      step :update_order_status
      step :assign_car_to_order
      step :send_car_assignment_email_to_user
      step :update_car_status
    }

    private

    def find_car(_options, params:, **)
      @car = Car[params['car_assignment']['car_id']]
    end

    def find_order(_options, params:, **)
      @order = Order[params['order_id']]
    end

    def add_order_id_to_car_assignment_params(_options, params:, **)
      params[:car_assignment].merge!(order_id: params[:order_id])
    end

    def update_order_status(*)
      @order.update(order_status: 'In progress')
    end

    def assign_car_to_order(*)
      @order.update(car_id: @car.id)
    end

    def send_car_assignment_email_to_user( *)
      UserMailer.car_assignment_mail(@order.user, @car) if @order.user_id
      true
    end

    def update_car_status(*)
      @car.update(car_status: 'Ordered')
    end
  end
end
