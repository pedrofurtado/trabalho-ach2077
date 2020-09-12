FactoryBot.define do
  factory :medical_appointment do
    association :patient, factory: :patient
    association :employee, factory: :employee
    sequence(:scheduled_at) { |n| Date.current + n.days }
    sequence(:start_time) { '10:30' }
    sequence(:finish_time) { '14:30' }
    sequence(:description) { |n| "#{Faker::Name.name} #{n}" }
  end
end
