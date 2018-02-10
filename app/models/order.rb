# Order model class
class Order < Sequel::Model
  many_to_one :car
  many_to_one :tax
  many_to_one :user # , -> { where role: 'client' }, optional: true
  one_to_one :invoice

  STATUSES = [
    NEW = 'New'.freeze,
    IN_PROGRESS = 'In progress'.freeze,
    COMPLETED = 'Completed'.freeze
  ].freeze

  # scope :search_by_client_phone, ->(desired_phone) do where('client_phone LIKE ?', "%#{desired_phone}%").order('order_status ASC') end
end
