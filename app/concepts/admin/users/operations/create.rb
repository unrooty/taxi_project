module Admin::User
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL

    class Present < Trailblazer::Operation
      step Model(User, :new)
      step self::Contract::Build(constant: Admin::User::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()
  end
end
