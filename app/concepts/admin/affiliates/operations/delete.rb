module Admin::Affiliate
  class Delete < Trailblazer::Operation
    step Model(Affiliate, :[])
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
    step Wrap(SequelTransaction) {
      step :remove_from_cars!
      step :delete!
    }

    private

    def remove_from_cars!(_options, model:, **)
      model.cars.update_all(affiliate_id: nil) unless model.cars.empty?
      true
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
