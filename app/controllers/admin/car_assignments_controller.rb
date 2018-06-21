module Admin
  #
  class CarAssignmentsController < AdminController
    def new
      result = Admin::CarAssignment::Create::Present.call(params: params,
                                                          current_user: current_user)
      handle_successful(result)
    end

    def create
      result = Admin::CarAssignment::Create.call(params: params,
                                                 current_user: current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('car_assigned')
      end

      handle_invalid(result) do
        if result['contract.default'].errors[:order_id]
          return redirect_to admin_orders_path,
                             notice: @form.errors.full_messages.last
        end
        render :new
      end
    end

    def edit
      result = Admin::CarAssignment::Update::Present.call(params: params,
                                                          current_user: current_user)
      handle_successful(result)
    end

    def update
      result = Admin::CarAssignment::Update.call(params: params,
                                                 current_user: current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('car_reassigned')
      end

      handle_invalid(result) do
        render :edit
      end
    end

    def driver_car_assignment
      result = Admin::CarAssignment::DriverCarAssignment.call(params: params,
                                                              current_user: current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('car_assigned')
      end
      handle_invalid(result) do
        redirect_to admin_orders_path,
                    notice: @form.errors.full_messages.last
      end
    end
  end
end
