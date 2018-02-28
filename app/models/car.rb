# Car model class
class Car < Sequel::Model
  many_to_one :affiliate
  one_to_one :user, key: :id
  one_to_many :orders
  STATUSES = [
    FREE = 'Free'.freeze,
    ORDERED = 'Ordered'.freeze
  ].freeze

  STATUSES.each do |status|
    define_method status.downcase do
      where(status: status)
    end
  end

  def car_info
    "#{brand} #{car_model}, #{I18n.t('activerecord.attributes.car.reg_number')}:
     #{reg_number}, #{I18n.t("car_status.#{car_status}")}"
  end
end
