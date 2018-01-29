# Tax model class.
class Tax < ApplicationRecord
  has_many :orders
  def full_tax
    "#{cost_per_km}, #{basic_cost}"
  end
end
