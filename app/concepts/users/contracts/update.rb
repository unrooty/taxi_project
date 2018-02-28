module User::Contract
  class Update < Reform::Form
    include ActiveModel::Validations
    model User
    property :first_name
    property :last_name
    property :email
    property :password
    property :password_confirmation
    property :current_password
    property :phone
    validates :phone, presence: true, length: { is: 9 }
    validates :first_name, :last_name, presence: true
    validates :password, length: { minimum: 8, maximum: 128, allow_blank: true },
                         confirmation: true
    validates :email, uniqueness: true, presence: true
    validates :current_password, presence: true
  end
end
