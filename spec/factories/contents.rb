FactoryBot.define do
  factory :content do
    association :user

    title               { Faker::Name.initials(number: 5) }
    text                { Faker::Name.initials(number: 200) }

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
