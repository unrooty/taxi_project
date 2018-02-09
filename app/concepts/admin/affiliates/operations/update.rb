module Admin::Affiliate
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Affiliate, :[])
      step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
      step self::Contract::Build(constant: Admin::Affiliate::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :affiliate)
    step self::Contract::Persist()
  end
end
