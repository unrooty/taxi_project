# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Affiliate.create name: 'Taxi-service', address: 'Гродно, ул. Кабяка, д.17'
Affiliate.create name: 'Taxi-universe', address: 'Гродно, ул. Гоголя, д.1'

User.create first_name: 'Paul', last_name: 'Admin', role: :administrator,
            phone: '25-755-55-50', email: 'adminexample@gmail.com',
            password: '123456789', password_confirmation: '123456789', confirmed_at: Time.now
User.create first_name: 'Alex', last_name: 'Driver', role: :driver,
            phone: '25-755-55-51', email: 'driverexample1@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now
User.create first_name: 'Alexa', last_name: 'Driver', role: :driver,
            phone: '25-755-55-52', email: 'driverexample2@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now
User.create first_name: 'Rick', last_name: 'Driver', role: :driver,
            phone: '25-755-55-53', email: 'driverexample3@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now
User.create first_name: 'Denis', last_name: 'Client', role: :client,
            phone: '25-755-55-54', email: 'clientexample@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now
User.create first_name: 'Alexa', last_name: 'Dispatcher', role: :dispatcher,
            phone: '25-755-55-52', email: 'dispatcherexample@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now
User.create first_name: 'Ann', last_name: 'Accountant', role: :accountant,
            phone: '25-755-55-53', email: 'accountantexample@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now
User.create first_name: 'Din', last_name: 'Manager', role: :manager,
            phone: '25-755-55-54', email: 'managerexample@gmail.com',
            password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now

Tax.create name: 'Basic', cost_per_km: '0.5', basic_cost: '2', by_default: true
Tax.create name: 'Out-of-town', cost_per_km: '1.2', basic_cost: '2'

Car.create brand: 'Audi', car_model: 'A8',
           reg_number: 'AA-4444-4', color: 'Black', style: 'Sedan',
           affiliate_id: 1, user_id: 2
Car.create brand: 'Lada', car_model: '2108',
           reg_number: 'AA-6666-4', color: 'Baklazhan', style: 'Sedan',
           affiliate_id: 1, user_id: 3
Car.create brand: 'Mazda', car_model: '3',
           reg_number: 'AA-7777-4', color: 'White', style: 'Universal',
           affiliate_id: 2, user_id: 4
