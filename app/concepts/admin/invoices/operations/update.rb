module Admin::Invoice
  class Update < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Invoice, :find_by)
      step Policy::Pundit(Admin::InvoicesPolicy, :can_work_with_invoice?)
      step self::Contract::Build(constant: Admin::Invoice::Contract::Update)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :invoice)
    step Wrap ->(*, &block) { Invoice.transaction { block.call } } {
      step self::Contract::Persist()
      step :add_additional_amount_to_payed_amount
      step :take_away_additional_amount_from_indebtedness
      step :update_invoice_status
      step :send_email_with_invoice_to_user
    }

    def add_additional_amount_to_payed_amount(options, *)
      p options['model'].payed_amount.class
      options['model'].payed_amount +=
        BigDecimal(options['params']['invoice']['additional_amount'])
    end

    def take_away_additional_amount_from_indebtedness(options, *)
      options['model'].indebtedness -=
        BigDecimal(options['params']['invoice']['additional_amount'])
    end

    def update_invoice_status(options, *)
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
