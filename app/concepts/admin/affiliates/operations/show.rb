module Admin::Affiliate
  class Show < Trailblazer::Operation
    step Model(Affiliate, :[])
    step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
  end
end
