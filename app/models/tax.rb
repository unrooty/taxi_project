# Tax model class.
class Tax < ApplicationRecord
  has_many :orders

  validates :cost_per_km, :basic_cost, presence: true
  validates :cost_per_km, :basic_cost,
            numericality: { greater_than_or_equal_to: 0 }

  def full_tax
    "#{cost_per_km}, #{basic_cost}"
  end
end
