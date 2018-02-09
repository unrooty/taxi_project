module Admin::User
  class Update < Trailblazer::Operation

    class Present < Trailblazer::Operation
      step Model(User, :[])
      step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
      step self::Contract::Build(constant: Admin::User::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()
  end
end
