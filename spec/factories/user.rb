

FactoryBot.define do
  factory :user do
    name                   "Test User"
    email                  "user@user.com"
    password               "password"
    password_confirmation  "password"
    confirmed_at { Faker::Date.between(40.years.ago, Time.zone.today) }
  end
end