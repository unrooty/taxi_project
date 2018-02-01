module Admin::Tax
  class Delete < Trailblazer::Operation
    step Model(Tax, :find_by)
    step Policy::Pundit(Admin::TaxesPolicy, :can_manage?)
    step Wrap ->(*, &block) { Tax.transaction { block.call } } {
      step :remove_from_orders!
      step :delete!
    }

    private

    def remove_from_orders!(_options, model:, **)
      model.orders.update_all(tax_id: nil)
    end

    def delete!(_options, model:, **)
      model.update(deleted: true)
    end
  end
end
