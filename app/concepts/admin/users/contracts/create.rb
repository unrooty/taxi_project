module Admin::User
  module Contract
    class Create < Reform::Form
      include ActiveModel::Validations
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
      validates :phone, presence: true, length: { is: 9 }
      validates :first_name, :last_name, :role, :language, presence: true
      validates :password, presence: true, confirmation: true
      validates :password_confirmation, presence: true
      validates :email, uniqueness: true, presence: true
      #:validation end
    end
  end
end
