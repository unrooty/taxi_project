module Admin::User
  class Index < Trailblazer::Operation
    step :model!

    private

    def model!(operation, *)
      operation['model'] = User.all
    end
  end
end
