module Admin
  #
  class BillingController < AdminController
    def new
      @billing = Billing.new
    end

    def create
      @billing = Billing.new(billing_params.merge(order_id: params[:order_id]))
      if @billing.save
        redirect_to admin_orders_path
      else
        redirect_to new_admin_order_billing_path, notice: t('check_correct')
      end
    end

    private

    def billing_params
      params.require(:billing).permit(:distance,
                                      :order_id,
                                      :invoice_status,
                                      :payed_amount)
    end
  end
end
