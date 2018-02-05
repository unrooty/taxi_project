module Admin::Invoice
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL

    class Present < Trailblazer::Operation
      step Model(Invoice, :new)
      step Policy::Pundit(Admin::InvoicesPolicy, :can_work_with_invoice?)
      step self::Contract::Build(constant: Admin::Invoice::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :invoice)
    step Wrap ->(*, &block) { Invoice.transaction(&block) } {
      step self::Contract::Persist()
      step :set_order_id_to_invoice
      step :count_total_price
      step :update_order_status_to_completed
      step :update_car_status_to_free
      step :count_indebtedness
      step :set_invoice_status
      step :send_email_with_invoice_to_user
    }

    private

    def set_order_id_to_invoice(options, *)
      options['model'].order_id = options['params']['order_id']
    end

    def count_total_price(options, *)
      tax = options['model'].order.tax
      options['model'].total_price = options['model'].distance *
          tax.cost_per_km +
          tax.basic_cost
    end

    def count_indebtedness(options, *)
      options['model'].update(indebtedness: options['model'].total_price -
          options['model'].payed_amount)
    end

    def update_order_status_to_completed(options, *)
      options['model'].order.update(order_status: 2)
    end

    def update_car_status_to_free(options, *)
      options['model'].order.car.update(car_status: 0)
    end

    def set_invoice_status(options, *)
      if options['model'].indebtedness.zero?
        options['model'].update(invoice_status: 0)
      elsif options['model'].payed_amount.zero? &&
          options['model'].indebtedness != 0
        options['model'].update(invoice_status: 1)
      else
        options['model'].update(invoice_status: 2)
      end
    end

    def send_email_with_invoice_to_user(options, *)
      if options['model'].order.user_id
        user = User.find(options['model'].order.user_id)
        UserMailer.invoice_report_mail(user, options['model'])
      end

      true
    end
  end
end
