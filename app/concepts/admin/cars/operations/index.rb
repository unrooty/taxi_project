module Admin::Car
  class Index < Trailblazer::Operation
    step :model!

    private

    def model!(options, *)
      options['model'] = Car.all
    end
  end
end
