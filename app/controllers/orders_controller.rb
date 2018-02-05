class OrdersController < ApplicationController
  include Matcher
  respond_to :js
  before_action :authenticate_user!, except: %i[new create]

  def index
    run Order::Index, params, current_user: current_user
  end

  def new
    result = Order::Create::Present.call(params)
    handle_successful(result)
  end

  def create
    result = Order::Create.call(params, 'current_user' => current_user)
    handle_successful(result) do
      redirect_to root_path, notice: t('order_created')
    end
    handle_invalid(result) do
      render :new
    end
  end

  def show
    result = Order::Show.call(params, 'current_user' => current_user)
    handle_successful(result)
  end

  def edit
    result = Order::Update::Present.call(params, 'current_user' => current_user)
    handle_successful(result)
  end

  def update
    result = Order::Update.call(params, 'current_user' => current_user)
    handle_successful(result) do
      redirect_to orders_path(@model.id), notice: t('order_updated')
    end
    handle_invalid(result) do
      render :edit
    end
  end

  def destroy
    result = Order::Delete.call(params, 'current_user' => current_user)
    handle_successful(result) do
      flash[:notice] = t('order_destroyed')
    end
  end

  def send_email_with_orders
    result = Order::SendEmailWithOrders.call(params, 'current_user' => current_user)
    handle_successful(result) do
      redirect_to orders_path, notice: t('order_sent')
    end
  end

  def generate_orders_pdf
    result = Order::SendEmailWithOrders.call(params, 'current_user' => current_user)
    handle_successful(result) do
      render pdf: 'generate_orders_pdf.pdf.haml'
    end
  end
end
