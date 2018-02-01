require 'trailblazer/endpoint/rails'
class OrdersController < ApplicationController
  include Matcher
  respond_to :js
  before_action :authenticate_user!, except: %i[new create show]

  def index
    run Order::Index, params, current_user: current_user
  end

  def new
    run Order::Create::Present
  end

  def show
    result = Order::Show.call(params, 'current_user' => current_user)
    match(%w[success unauthorized not_found]).call(result) do |m|
      m.success { @model = result['model'] }
      m.unauthorized { redirect_to orders_path, notice: t('access_denied') }
      m.not_found { redirect_to orders_path, notice: t('record_not_found') }
    end
  end

  def edit
    result = Order::Update::Present.call(params, 'current_user' => current_user)
    match(%w[success unauthorized not_found]).call(result) do |m|
      m.success do
        @form = result['contract.default']
        @model = result['model']
      end
      m.unauthorized { redirect_to orders_path, notice: t('access_denied') }
      m.not_found { redirect_to orders_path, notice: t('record_not_found') }
    end
  end

  def create
    run Order::Create, params, 'current_user' => current_user do
      return redirect_to root_path, notice: t('order_created')
    end

    render :new
  end

  def update
    result = Order::Update.call(params, 'current_user' => current_user)
    match(%w[success invalid]).call(result) do |m|
      m.success { redirect_to order_path(result['model'].id) }
      m.invalid do
        @form = result['contract.default']
        @model = result['model']
        render :edit
      end
    end
  end

  def destroy
    result = Order::Delete.call(params, 'current_user' => current_user)
    match(%w[success unauthorized not_found]).call(result) do |m|
      m.success do
        @model = result['model']
      end
      m.unauthorized { redirect_to orders_path, notice: t('access_denied') }
      m.not_found { redirect_to orders_path, notice: t('record_not_found') }
    end
  end

  def send_email_with_orders
    result = Order::SendEmailWithOrders.call(params, 'current_user' => current_user)
    match(%w[success unauthorized]).call(result) do |m|
      m.success { redirect_to orders_path, notice: t('order_sent') }
      m.unauthorized { redirect_to orders_path, notice: t('access_denied') }
    end
  end

  def generate_orders_pdf
    result = Order::SendEmailWithOrders.call(params, 'current_user' => current_user)
    match(%w[success unauthorized]).call(result) do |m|
      m.success do
        @user = current_user
        @model = result['model']
        render pdf: 'generate_orders_pdf.pdf.haml'
      end
      m.unauthorized { redirect_to orders_path, notice: t('access_denied') }
    end
  end
end
