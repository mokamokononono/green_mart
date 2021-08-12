FactoryBot.define do
  factory :itemcomment do
    association :user, :item
    text { Faker::Lorem.sentence }
  end
end
