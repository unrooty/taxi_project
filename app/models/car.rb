# Car model class
class Car < ApplicationRecord
  belongs_to :affiliate, touch: true
  belongs_to :user, -> { where role: 'driver' }
  has_many :orders

  validates :brand, :model, :reg_number, :color, :style, presence: true
  validates :reg_number, uniqueness: true, format: /\A[A-Z]{2}-\d{4}-\d/
  validates :brand, :model, :color, :style, length: { maximum: 15 }

  enum car_status: %w[free ordered]

  def car_info
    "#{brand} #{model}, #{I18n.t('activerecord.attributes.car.reg_number')}:
     #{reg_number}, #{I18n.t("car_status.#{car_status}")}"
  end
end
