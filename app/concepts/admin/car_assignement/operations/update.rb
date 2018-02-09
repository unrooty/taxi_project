module Admin::CarAssignment
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(OpenStruct, :new)
      step self::Contract::Build(constant:
                                     Admin::CarAssignment::Contract::Update)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :car_assignment)
    step Wrap ->(*, &block) { Sequel::Model.db.transaction { block.call } } {
      step :find_car
      step :find_order
      step :remove_previous_car_from_order
      step :update_car_status
      step :assign_car_to_order
      step :send_car_assignment_email_to_user
    }

    private

    def find_car(options, *)
      @car = Car[options[:params]['car_assignment']['car_id']]
    end

    def find_order(options, *)
      @order = Order[options[:params]['order_id']]
    end

    def remove_previous_car_from_order(*)
      @order.car.update(car_status: :free)
    end

    def update_car_status(*)
      @car.update(car_status: :ordered)
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
