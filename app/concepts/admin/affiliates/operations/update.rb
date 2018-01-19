class Affiliate::Update < Trailblazer::Operation
  extend Contract::DSL
  class Present < Trailblazer::Operation
    step Model(Affiliate, :find_by)
    step Contract::Build(constant: Affiliate::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :affiliate)
  step Contract::Persist()
end