# Affiliate model class
class Affiliate < ApplicationRecord
  has_many :cars
  has_many :users
end
