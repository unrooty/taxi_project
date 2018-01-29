module Admin::Affiliate
  class Show < Trailblazer::Operation
    step Model(Affiliate, :find_by)
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
  end
end
