# Affiliate model class
class Affiliate < ApplicationRecord
  has_many :cars
  has_many :users

  validates :name, :address, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 25 }
  validates :address, length: { maximum: 40 }
end
