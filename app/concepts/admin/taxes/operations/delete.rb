module Admin::Tax
  class Delete < Trailblazer::Operation
    step Model(Tax, :[])
    step Policy::Pundit(Admin::TaxesPolicy, :can_manage?)
    step :delete!

    private

    def delete!(_options, model:, **)
      return model.update(deleted: true) unless model.by_default
      model.destroy if Order.where(tax_id: model.id) && !model.by_default
    end
  end
end
