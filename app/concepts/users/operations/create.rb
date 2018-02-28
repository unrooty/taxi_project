class User::Create < Trailblazer::Operation

  step Model(User, :new)
  step Contract::Build(constant: User::Contract::Create)
  step :bring_number_to_right_format
  step Contract::Validate(key: :user)

  private

  def bring_number_to_right_format(_options, params:, **)
    params['user']['phone'].gsub!(/[^\d]/, '')
    true
  end
end
