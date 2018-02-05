module Admin::User
  class Update < Trailblazer::Operation
    extend Update::Contract::DSL

    class Present < Trailblazer::Operation
      step Model(User, :find_by)
      step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
      step self::Contract::Build(constant: Admin::User::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()
  end
end
