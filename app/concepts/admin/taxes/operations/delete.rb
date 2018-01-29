module Admin::Tax
  class Delete < Trailblazer::Operation
    step Model(Tax, :find_by)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction { block.call } } {
      step :remove_from_orders!
      step :delete!
    }

    private

    def remove_from_orders!(_options, model:, **)
      model.orders.update_all(tax_id: nil)
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
