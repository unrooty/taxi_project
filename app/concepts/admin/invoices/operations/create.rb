module Admin::Invoice
  class Create < Trailblazer::Operation

    class Present < Trailblazer::Operation
      step Model(Invoice, :new)
      step Policy::Pundit(Admin::InvoicesPolicy, :can_work_with_invoice?)
      step self::Contract::Build(constant: Admin::Invoice::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :invoice)
    step Wrap ->(*, &block) { Invoice.db.transaction { block.call } } {
      step self::Contract::Persist()
      step :set_order_id_to_invoice
      step :find_order
      step :count_total_price
      step :update_order_status_to_completed
      step :update_car_status_to_free
      step :count_indebtedness
      step :set_invoice_status
      step :send_email_with_invoice_to_user
    }

    private

    def set_order_id_to_invoice(_options, model:, params:, **)
      model.order_id = params['order_id']
    end

    def find_order(_options, model:, **)
      @order = Order[model.order_id]
    end

    def count_total_price(_options, model:, **)
      tax = @order.tax
      model.total_price = model.distance *
          tax.cost_per_km +
          tax.basic_cost
    end

    def count_indebtedness(_options, model:,  **)
      model.update(indebtedness: model.total_price -
                                 model.payed_amount)
    end

    def update_order_status_to_completed(_options, **)
      @order.update(order_status: 'Completed')
    end

    def update_car_status_to_free(_options, **)
      @order.car.update(car_status: 'Free')
    end

    def set_invoice_status(_options, model:, **)
      if model.indebtedness.zero?
        model.update(invoice_status: 'Paid')
      elsif model.payed_amount.zero? && model.indebtedness != 0
        model.update(invoice_status: 'Unpaid')
      else
        model.update(invoice_status: 'Partially paid')
      end
    end

    def send_email_with_invoice_to_user(_options, model:, **)
      if @order.user_id
        user = User[@order.user_id]
        UserMailer.invoice_report_mail(user, model)
      end

      true
    end
  end
end
