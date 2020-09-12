FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
    sequence(:password) { Faker::Internet.password }
    confirmed_at DateTime.now
  end
end
