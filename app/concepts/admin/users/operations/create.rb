module Admin::User
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
      step self::Contract::Build(constant: Admin::User::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :user)
    step Wrap ->(*, &block) { User.db.transaction { block.call } } {
      step self::Contract::Persist()
      step :bind_user_to_manager_affiliate
    }

    def bind_user_to_manager_affiliate(_options, model:, current_user:, **)
      if current_user.role == 'Manager'
        model.update(affiliate_id: current_user.affiliate_id)
      end
      true
    end
  end
end
