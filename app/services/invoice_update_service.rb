# Service for correct update of invoice
class InvoiceUpdateService
  def initialize(params)
    @invoice = params[:invoice]
    @external_amount = params[:external_amount]
  end

  def update_invoice
    return false if @external_amount.to_f < 0
    indebtedness_check
    Invoice.find(@invoice.id).update(payed_amount: @invoice.payed_amount,
                                     invoice_status: @invoice.invoice_status,
                                     indebtedness: @invoice.indebtedness)
  end

  def indebtedness_check
    @invoice.payed_amount += @external_amount.to_f
    if @invoice.payed_amount >= @invoice.total_price
      @invoice.invoice_status = 0
      @invoice.indebtedness = 0
    else
      @invoice.indebtedness = @invoice.total_price.to_f - @invoice.payed_amount.to_f
    end
  end
end
