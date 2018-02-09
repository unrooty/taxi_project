module Admin::Tax
  class Index < Trailblazer::Operation
    step :model!
    step Policy::Pundit(Admin::TaxesPolicy, :index?)

    private

    def model!(options, *)
      options['model'] = Tax.where(deleted: false)
    end
  end
end
