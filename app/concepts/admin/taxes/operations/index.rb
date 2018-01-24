module Admin::Tax
  class Index < Trailblazer::Operation
    step :model!

    private

    def model!(options, *)
      options['model'] = Tax.all
    end
  end
end
