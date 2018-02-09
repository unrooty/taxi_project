module Admin::Tax
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Tax, :[])
      step Policy::Pundit(Admin::TaxesPolicy, :can_manage?)
      step self::Contract::Build(constant: Admin::Tax::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :tax)
    step self::Contract::Persist()
  end
end
