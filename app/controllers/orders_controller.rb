class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit update show]
  before_action :authenticate_user!, except: %i[new create show]
  load_and_authorize_resource

  def index
    @orders = current_user.orders.all
  end

  def new
    @order = Order.new
    @tax = Tax.find_by(name: 'Basic').id
  end

  def show
    @status = @order.order_status
  end

  def edit; end

  def create
    @order = Order.new(order_params)
    @order.tax_id = Tax.find_by_name('Basic').id
    if @order.save && user_signed_in?
      @order.update(user_id: current_user.id)
      redirect_to order_path(@order.id), notice: t('order_created')
    elsif @order.save && !user_signed_in?
      redirect_to order_path(@order)
    else
      render 'new'
    end
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order.id), notice: t('order_updated')
    else
      render :edit
    end
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
