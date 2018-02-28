module Admin::Tax
  module Contract
    class SetDefault < Reform::Form
      #:property
      property :id
      #:property end

      #:validation
      validates :id, presence: true
      validate :tax_not_default

      private

      def tax_not_default
        if Tax[id].by_default
          errors.add(:tax, I18n.t('already_default'))
        end
      end

      #:validation end
    end
  end
end
