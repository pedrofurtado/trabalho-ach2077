class Patient < ApplicationRecord
  has_many :medical_appointments
  validates :name, presence: true
  validates :sex, presence: true
  validates :birthday, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :description, presence: true
end
