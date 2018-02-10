module Admin::Affiliate
  class ShowAffiliateWorkers < Trailblazer::Operation
    step Model(Affiliate, :[])
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
    step :find_workers!

    private

    def find_workers!(options, *)
      options['workers'] = User.where(affiliate_id: options[:model].id).exclude(role: 'Client')
    end
  end
end
