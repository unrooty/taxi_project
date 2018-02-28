# require 'app/lib/validator/unique_validator
module Admin::Affiliate
  module Contract
    class Create < Reform::Form
      include ActiveModel::Validations
      #:property
      property :name
      property :address
      #:property end

      #:validation
      validates :name, :address, presence: true
      validates :name, uniqueness: true
    end
  end
end
