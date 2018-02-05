# User model class
class User < ApplicationRecord
  belongs_to :affiliate, optional: true
  has_many :orders
  has_one :car
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  enum role: %i[admin manager accountant dispatcher driver client]
  enum language: %w[Русский English]

  def after_confirmation
    welcome_email
  end

  private

  def welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
