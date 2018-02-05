require "reform/form/validation/unique_validator"
module Admin::User
  module Contract
    class Create < Reform::Form
      #:property
      property :first_name
      property :last_name
      property :phone
      property :email
      property :affiliate_id
      property :role
      property :language
      property :password
      property :password_confirmation
      #:property end

      #:validation
      validates :email, unique: true
      validates :phone, presence: true, format: /\A\d{2}-\d{3}-\d{2}-\d{2}/, 
                        unique: true
      #:validation end
    end
  end
end
