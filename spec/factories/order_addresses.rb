FactoryBot.define do
  factory :order_address do
    zip_code      { '123-4567' }
    prefecture_id { 15 }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { Faker::Space.planet + Faker::Address.building_number }
    phone_number  { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
