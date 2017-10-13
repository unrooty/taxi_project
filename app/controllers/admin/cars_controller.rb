module Admin
  #
  class CarsController < AdminController
    before_action :set_car, only: %i[edit update destroy show]

    def index
      @cars = Car.all
    end

    def new
      @car = Car.new
    end

    def show; end

    def edit; end

    def create
      @car = Car.new(car_params)
      if @car.save
        redirect_to admin_car_path(@car.id),
                    notice: t('car_create', car_model: @car.model,
                                            car_brand: @car.brand)
      else
        render :new
      end
    end

    def update
      if @car.update(car_params)
        redirect_to admin_car_path(@car.id), notice: t('car_update')
      else
        render :edit
      end
    end

    def destroy
      @car.orders.update_all(car_id: nil) if @car.destroy

      redirect_to admin_cars_path, notice: t('car_deleted')
    end

    private

    def set_car
      @car = Car.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_cars_path, notice: t('record_not_found')
    end

    def car_params
      params.require(:car).permit(
        :brand,
        :model,
        :reg_number,
        :color,
        :style,
        :affiliate_id,
        :user_id,
        :tax_id
      )
    end
  end
end
