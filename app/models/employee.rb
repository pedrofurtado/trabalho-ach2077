class Employee < ApplicationRecord
  has_many :medical_appointments
  validates :name, presence: true
  validates :email, presence: true
  validates :job, presence: true
  validates :phone, presence: true
end
