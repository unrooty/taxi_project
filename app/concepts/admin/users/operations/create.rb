module Admin::User
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
      step self::Contract::Build(constant: Admin::User::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :user)
    step Wrap ->(*, &block) { User.transaction(&block) } {
      step self::Contract::Persist()
      step :bind_user_to_manager_affiliate
    }

    def bind_user_to_manager_affiliate(options, *)
      if options['current_user'].role == 'manager'
        options['model'].update(affiliate_id: options['current_user'].affiliate_id)
      end
      true
    end
  end
end
