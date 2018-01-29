module Admin::Affiliate
  class Update < Trailblazer::Operation
    extend Update::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Affiliate, :find_by)
      step self::Contract::Build(constant: Admin::Affiliate::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :affiliate)
    step self::Contract::Persist()
  end
end
