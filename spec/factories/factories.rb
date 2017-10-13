FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    email 'admin@gmail.com'
    password '123456'
    role 'admin'
    phone '123698547896'
    affiliate_id '1'
  end
end
