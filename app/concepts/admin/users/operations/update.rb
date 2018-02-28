module Admin::User
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :[])
      step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
      step self::Contract::Build(constant: Admin::User::Contract::Create)
    end

    step Nested(Present)
    step :bring_number_to_right_format
    step self::Contract::Validate(key: :user)
    step self::Contract::Persist()

    private

    def bring_number_to_right_format(_options, params:, **)
      params['user']['phone'].gsub!(/[^\d]/, '')
      true
    end
  end
end
