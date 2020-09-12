class MedicalAppointment < ApplicationRecord
  belongs_to :patient
  belongs_to :employee

  validates :patient, presence: true
  validates :employee, presence: true
  validates :scheduled_at, presence: true
  validates :start_time, presence: true, format: { with: /\A[0-9]{2}:[0-9]{2}\z/, message: "tem formato invalido" }
  validates :finish_time, presence: true, format: { with: /\A[0-9]{2}:[0-9]{2}\z/, message: "tem formato invalido" }
  validates :description, presence: true
end
