class OrdersController < ApplicationController
  respond_to :js
  before_action :authenticate_user!, except: %i[new create show]
  load_and_authorize_resource

  def index
    run Order::Index, params, current_user: current_user
  end

  def new
    run Order::Create::Present
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
    run Order::Delete do
      flash[:notice] = t('order_destroyed')
    end
  end

  def send_orders_mail
    run Order::SendOrdersMail, params, current_user: current_user do
      redirect_to orders_path, notice: t('order_sent')
    end

  end

  def generate_orders_pdf
    @user = current_user
    @orders = @user.orders.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'generate_orders_pdf.pdf.haml'
      end
    end
  end

  private

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
