module Admin::Affiliate
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Affiliate, :new)
      step self::Contract::Build(constant: Admin::Affiliate::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :affiliate)
    step self::Contract::Persist()
  end
end
