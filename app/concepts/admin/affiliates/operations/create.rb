module Admin::Affiliate
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Affiliate, :new)
      step Policy::Pundit(Admin::AffiliatesPolicy, :user_admin?)
      step self::Contract::Build(constant: Admin::Affiliate::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :affiliate)
    step self::Contract::Persist()
  end
end
