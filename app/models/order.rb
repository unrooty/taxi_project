# Order model class
class Order < ApplicationRecord
  belongs_to :car, optional: true
  belongs_to :tax, optional: true
  belongs_to :user, -> { where role: 'client' }, optional: true
  has_one :invoice

  enum order_status: %i[fresh in_progress completed]

  private

  scope :search_by_client_phone, ->(desired_phone) do where('client_phone LIKE ?', "%#{desired_phone}%").order('order_status ASC') end
end
