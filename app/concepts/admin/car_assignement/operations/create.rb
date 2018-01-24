=begin
module Admin::CarAssignment
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(CarAssignment, :new)
      step self::Contract::Build(constant:
                                     Admin::CarAssignment::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate()
  end
end
=end
