
module Affiliate::Contract
  class Create < Reform::Form
    #:property
    property :name
    property :address
    #:property end

    #:validation
    validates :name, :address, presence: true
    validates_uniqueness_of :name
    validates :name, length: { maximum: 25 }
    validates :address, length: { maximum: 25 }
    #:validation end
  end
end
