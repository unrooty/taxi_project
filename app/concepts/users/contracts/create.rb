module User::Contract
  class Create < Reform::Form
    include ActiveModel::Validations
    property :first_name
    property :last_name
    property :email
    property :password
    property :password_confirmation
    property :phone
    validates :phone, presence: true, length: { is: 9 }
    validates :first_name, :last_name, presence: true
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
    validates :email, uniqueness: true, presence:true
  end
end
