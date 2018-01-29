module Admin::Tax
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL

    class Present < Trailblazer::Operation
      step Model(Tax, :new)
      step self::Contract::Build(constant: Admin::Tax::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :tax)
    step self::Contract::Persist()

  end
end
