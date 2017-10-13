module Admin
  #
  class InvoicesController < AdminController
    before_action :set_order, only: %i[edit update destroy show]

    def edit; end

    def update
      @invoice = InvoiceUpdateService.new(invoice: Invoice.find(params[:id]),
                                          external_amount:
                                              invoice_params[:payed_amount])
      if @invoice.update_invoice
        redirect_to admin_orders_path, notice: t('invoice_updated')
      else
        redirect_to edit_admin_order_invoice_path,
                    notice: t('invoice_update_error')
      end
    end

    def destroy
      @invoice = @order.invoices.find(params[:id])
      @invoice.destroy

      redirect_to admin_order_path(@order)
    end

    private

    def set_order
      @order = Order.find(params[:order_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_orders_path, notice: t('record_not_found')
    end

    def invoice_params
      params.require(:invoice).permit(:invoice_status,
                                      :order_id,
                                      :payed_amount,
                                      :distance)
    end
  end
end
