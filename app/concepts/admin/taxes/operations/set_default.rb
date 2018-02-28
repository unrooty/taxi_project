module Admin::Tax
  class SetDefault < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(OpenStruct, :new)
      step self::Contract::Build(constant: Admin::Tax::Contract::SetDefault)
      step :all_taxes

      private

      def all_taxes(options, **)
        options[:model] = Tax.all
      end
    end

    step Nested(Present)
    step self::Contract::Validate(key: :tax)
    step Wrap ->(*, &block) { Sequel::Model.db.transaction { block.call } } {
      step :set_previous_default_tax_as_not_default
      step :set_chosen_tax_as_default
    }

    private

    def set_previous_default_tax_as_not_default(_options, *)
      Tax.where(by_default: true).last.update(by_default: false)
    end

    def set_chosen_tax_as_default(_options, params:, **)
      Tax[params['tax']['id']].update(by_default: true)
    end
  end
end
