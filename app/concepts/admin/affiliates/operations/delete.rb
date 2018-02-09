module Admin::Affiliate
  class Delete < Trailblazer::Operation
    step Model(Affiliate, :[])
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
    step Wrap ->(*, &block) { Affiliate.db.transaction { block.call } } {
      step :remove_from_cars!
      step :delete!
    }

    private

    def remove_from_cars!(options, *)
      unless options[:model].cars == []
        options[:model].cars.update_all(affiliate_id: nil)
      end
      true
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
