# User model class
class User < Sequel::Model

  many_to_one :affiliate, optional: true
  one_to_many :orders
  one_to_one :car
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  plugin :devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  plugin :enum
  enum :role, %i[administrator manager accountant dispatcher driver client]
  enum :language, %i[Русский English]

  def after_confirmation
    welcome_email
  end

  def will_save_change_to_email?
  end

  private

  def welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
