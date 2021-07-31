FactoryBot.define do
  factory :item do
    association :user

    name                { Faker::Name.initials(number: 5) }
    price               { Faker::Number.within(range: 300..9_999_999) }
    amount              { Faker::Number.within(range: 0..30) }
    stock               { Faker::Number.within(range: 0..9_999_999) }  
    description         { Faker::Name.initials(number: 50) }
    category_id         { Faker::Number.within(range: 2..14) }
    condition_id        { Faker::Number.within(range: 2..5) }
    pesticides_id       { Faker::Number.within(range: 2..3) }
    shipping_charge_id  { Faker::Number.within(range: 2..3) }
    shipping_source_id  { Faker::Number.within(range: 2..48) }
    shipping_date_id    { Faker::Number.within(range: 2..4) }

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
