require 'rails_helper'

RSpec.describe Affiliate, type: :model do
  it 'affiliates' do
    affiliate = Affiliate.create(name: 'Minsk', address: 'Nezavisimosti 4')
    expect([affiliate.name, affiliate.address]).to eq(['Minsk',
                                                       'Nezavisimosti 4'])
  end
  it 'create car and user' do
    affiliate = Affiliate.create(name: 'Grodno', address: 'BLK 25')
    tax = Tax.create(cost_per_km: '20', basic_cost: '40')
    user = affiliate.users.create!(
      email: 'user@gmail.com',
      role: 'driver',
      first_name: 'nick',
      last_name: 'Ivanov',
      password: '123456'
    )
    car = affiliate.cars.create(
      brand: 'Volkswagen', model: 'golf 5',
      tax_id: tax.id, user_id: user.id,
      reg_number: 'AB 2142-4', color: 'blue',
      style: 'sedan'
    )
    expect([affiliate.users, affiliate.cars]).to eq([[user], [car]])
  end
end
RSpec.describe Affiliate, type: :model do
  it 'has one after adding one' do
    instance_double('Affiliate', name: 'Brest', address: 'Rokosovskogo 13')
  end

  it 'is not valid with empty name' do
    affiliate = Affiliate.new(address: 'as')
    expect(affiliate).not_to be_valid
  end

  it 'is not valid with empty address' do
    affiliate = Affiliate.new(name: 'as')
    expect(affiliate).not_to be_valid
  end

  it 'is not valid name > 25 letter' do
    affiliate = Affiliate.new(name: 'a' * 26)
    expect(affiliate).not_to be_valid
  end

  it 'is not valid address > 40 letter' do
    affiliate = Affiliate.new(name: 'a' * 41)
    expect(affiliate).not_to be_valid
  end
end
