FactoryBot.define do
  factory :user do
    nick_name             { Faker::Name.initials(number: 5) }
    kanji_family_name     { Gimei.last.kanji }
    kanji_given_name      { Gimei.first.kanji }
    katakana_family_name  { Gimei.last.katakana }
    katakana_given_name   { Gimei.first.katakana }
    date_of_birth         { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email                 { Faker::Internet.free_email }
    password              { '0a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    farmland_name         { '見本農園' }
    farmland_region       { 'みほん村' }
    hectare               { Faker::Number.within(range: 0..10000) }
    exp_year              { Faker::Number.within(range: 0..100) }
    crops                 { Faker::Food.vegetables }
  end
end
