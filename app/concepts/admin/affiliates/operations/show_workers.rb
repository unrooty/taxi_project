module Admin::Affiliate
  class ShowWorkers < Trailblazer::Operation
    step :model!
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
    step :find_workers!

    private

    def model!(options, params:, **)
      options[:model] = Affiliate[params[:affiliate_id]]
    end

    def find_workers!(options, *)
      options['workers'] = User.where(affiliate_id: options[:model].id).exclude(role: 'Client')
    end
  end
end
