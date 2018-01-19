class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit update show]
  before_action :authenticate_user!, except: %i[new create show]
  load_and_authorize_resource

  def index
    run Order::Index, params, current_user: current_user
  end

  def new
    run Order::Create::Present
    # @tax = Tax.find_by(name: 'Basic').id
  end

  def show
    run Order::Show
  end

  def edit
    run Order::Update::Present
  end

  def create
    run Order::Create, params, current_user: current_user do
      return redirect_to root_path, notice: t('order_created')
    end

    render :new
  end

  def update
    run Order::Update do
      return redirect_to root_path, notice: t('order_updated')
    end

    render :edit
  end

  def destroy
    @order.car.update(car_status: 0) unless @order.car.nil?
    @order.destroy
    respond_to do |format|
      format.js do
        flash.now[:notice] = t('invoice_deleted')
      end
    end
  end

  def send_orders_mail
    @orders = current_user.orders.all

    UserMailer.send_orders_mail(current_user, @orders).deliver
    flash[:notice] = t('order_sent')
    redirect_to orders_path
  end

  def pdf_orders
    @user = current_user
    @orders = @user.orders.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'pdf_orders.pdf.haml'
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: t('record_not_found')
  end

  def order_params
    params.require(:order).permit(
      :start_point,
      :end_point,
      :client_name,
      :client_phone,
      :order_status,
      :tax_id
    )
  end
end
