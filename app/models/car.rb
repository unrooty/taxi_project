# Car model class
class Car < Sequel::Model

  many_to_one :affiliate
  one_to_one :user, key: :id
  one_to_many :orders

  plugin :enum
  enum :car_status, %i[free ordered]

  def car_info
    "#{brand} #{car_model}, #{I18n.t('activerecord.attributes.car.reg_number')}:
     #{reg_number}, #{I18n.t("car_status.#{car_status}")}"
  end
end
