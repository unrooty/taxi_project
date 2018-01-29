module Admin::Tax
  class Update < Trailblazer::Operation
    extend Update::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Tax, :find_by)
      step self::Contract::Build(constant: Admin::Tax::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :tax)
    step self::Contract::Persist()
  end
end
