module Admin
  #
  class OrdersController < AdminController
    before_action :set_order, only: %i[edit update destroy show]
    before_action do
      redirect_to root_path, notice: t('access_denied') if current_user.client?
    end

    def index
      @orders = Order.search_by_client_phone(params[:desired_phone])
      respond_to do |f|
        f.html
        f.js
      end
    end

    def new
      @order = Order.new
    end

    def show
      @status = @order.order_status
    end

    def edit; end

    def create
      @order = Order.new(order_params)
      if @order.save
        redirect_to admin_orders_path, notice: t('order_created')
      else
        render :new
      end
    end

    def update
      if @order.update(order_params)
        redirect_to admin_order_path(@order.id), notice: t('order_updated')
      else
        render :edit
      end
    end

    def destroy
      @order.car.update(car_status: 0) unless @order.car.nil?
      @order.destroy
      redirect_to admin_orders_path, notice: t('order_destroyed')
    end

    private

    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_orders_path, notice: t('record_not_found')
    end

    def order_params
      params.require(:order).permit(:start_point,
                                    :end_point,
                                    :client_name,
                                    :client_phone,
                                    :order_status,
                                    :search,
                                    :tax_id)
    end
  end
end
