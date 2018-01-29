module Admin::Affiliate
  class Index < Trailblazer::Operation

    step :model!
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)

    private

    def model!(options, *)
      options['model'] = Affiliate.all
    end

  end
end
