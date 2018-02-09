module Admin::Tax
  class Delete < Trailblazer::Operation
    step Model(Tax, :[])
    step Policy::Pundit(Admin::TaxesPolicy, :can_manage?)
    step :delete!

    private

    def delete!(_options, model:, **)
      model.update(deleted: true)
    end
  end
end
