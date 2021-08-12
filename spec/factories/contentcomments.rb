FactoryBot.define do
  factory :contentcomment do
    association :user, :content
    text { Faker::Lorem.sentence }
  end
end
