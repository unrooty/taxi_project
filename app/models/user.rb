# User model class
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :affiliate, optional: true, touch: true
  has_many :orders, dependent: :destroy
  has_many :car
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :phone, presence: true, format: /\A\d{2}-\d{3}-\d{2}-\d{2}/
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
