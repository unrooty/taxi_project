# User model class
class User < Sequel::Model
  plugin :devise
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :validatable
  many_to_one :affiliate, optional: true
  one_to_many :orders
  one_to_one :car

  ROLES = [
    ADMIN = 'Admin'.freeze,
    CLIENT = 'Client'.freeze,
    DRIVER = 'Driver'.freeze,
    DISPATCHER = 'Dispatcher'.freeze,
    MANAGER = 'Manager'.freeze
  ].freeze

  LANGUAGES = %w[Russian English].freeze

  def after_confirmation
    welcome_email
  end

  def will_save_change_to_email?
    false
  end

  private

  def welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
