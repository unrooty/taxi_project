# Car model class
class Car < ApplicationRecord
  belongs_to :affiliate
  belongs_to :user, -> { where role: 'driver' }
  has_many :orders

  enum car_status: %w[free ordered]

  def car_info
    "#{brand} #{car_model}, #{I18n.t('activerecord.attributes.car.reg_number')}:
     #{reg_number}, #{I18n.t("car_status.#{car_status}")}"
  end
end
