FactoryBot.define do
  factory :employee do
    sequence(:name) { |n| "#{Faker::Name} #{n}" }
    sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
    sequence(:job) { |n| "#{Faker::Name} #{n}" }
    sequence(:phone) { |n| "#{Faker::PhoneNumber} #{n}" }
  end
end
