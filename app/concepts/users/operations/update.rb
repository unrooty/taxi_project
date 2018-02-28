class User::Update < Trailblazer::Operation

  step :add_current_user_id_to_params
  step Model(User, :[])
  step Contract::Build(constant: User::Contract::Update)
  step :bring_number_to_right_format
  step Contract::Validate(key: :user)

  private

  def add_current_user_id_to_params(_options, params:, current_user:, **)
    params.merge!(id: current_user.id)
  end

  def bring_number_to_right_format(_options, params:, **)
    params['user']['phone'].gsub!(/[^\d]/, '')
    true
  end
end
