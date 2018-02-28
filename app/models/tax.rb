# Tax model class.
class Tax < Sequel::Model

  one_to_many :orders

  def full_tax
    "#{cost_per_km}, #{basic_cost}"
  end
end
