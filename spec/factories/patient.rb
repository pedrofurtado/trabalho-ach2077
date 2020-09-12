FactoryBot.define do
  factory :patient do
    sequence(:name) { |n| "#{Faker::Name.name} #{n}" }
    sequence(:sex) { |n| "#{Faker::Name.name} #{n}" }
    sequence(:birthday) { |n| Date.current + n.days }
    sequence(:email) { |n| "#{Faker::Internet.email} #{n}" }
    sequence(:phone) { |n| "#{Faker::PhoneNumber} #{n}" }
    sequence(:description) { |n| "#{Faker::Name.name} #{n}" }
  end
end
