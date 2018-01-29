module Admin
  #
  class CarAssignmentsController < AdminController
    def new
      run Admin::CarAssignment::Create::Present
    end

    def create
      run Admin::CarAssignment::Create do
        return redirect_to admin_orders_path, notice: t('car_assigned')
      end
      flash.now[:alert] = "Car can't be assigned."
      render :new
    end

    def edit
      run Admin::CarAssignment::Update::Present
    end

    def update
      run Admin::CarAssignment::Update do
        return redirect_to admin_orders_path, notice: t('car_reassigned')
      end
      flash.now[:alert] = "Car can't be assigned."
      render :edit
    end

    def driver_car_assignment
      run Admin::CarAssignment::DriverCarAssignment, params,
          'current_user' => current_user do
        return redirect_to admin_orders_path, notice: t('car_assigned')
      end
      redirect_to admin_orders_path, notice: "Car can't be assigned."
    end
  end
end
