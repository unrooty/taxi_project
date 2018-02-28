# Affiliate model class
class Affiliate < Sequel::Model
  one_to_many :cars
  one_to_many :users
end
