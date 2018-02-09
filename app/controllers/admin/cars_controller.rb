module Admin
  #
  class CarsController < AdminController
    def index
      result = Admin::Car::Index.call(params: params,
                                      current_user: current_user)
      handle_successful(result)
    end

    def new
      result = Admin::Car::Create::Present.call(params: params,
                                                current_user: current_user)
      handle_successful(result)
    end

    def create
      result = Admin::Car::Create.call(params: params,
                                       current_user: current_user)
      handle_successful(result) do
        redirect_to admin_car_path(@model.id),
                    notice: t('car_create',
                              car_brand: @model.brand,
                              car_model: @model.car_model)
      end
      handle_invalid(result) do
        render :new
      end
    end

    def show
      result = Admin::Car::Show.call(params: params,
                                     current_user: current_user)
      handle_successful(result)
    end

    def edit
      result = Admin::Car::Update::Present.call(params: params,
                                                current_user: current_user)
      handle_successful(result)
    end

    def update
      result = Admin::Car::Update.call(params: params,
                                       current_user: current_user)
      handle_successful(result) do
        redirect_to admin_car_path(@model.id),
                    notice: t('car_update')
      end
      handle_invalid(result) do
        render :edit
      end
    end

    def destroy
      result = Admin::Car::Delete.call(params: params,
                                       current_user: current_user)
      handle_successful(result) do
        redirect_to admin_cars_path,
                    notice: t('car_deleted')
      end
    end

    protected

    def not_found_redirect_path
      admin_cars_path
    end
  end
end
