describe 'As a User' do
  it 'I can create a new medical_appointment' do
    login_as FactoryBot.create(:user), scope: :user

    medical_appointment = FactoryBot.build :medical_appointment

    visit new_medical_appointment_path

    select medical_appointment.patient.name, from: 'medical_appointment[patient_id]'
    select medical_appointment.employee.name, from: 'medical_appointment[employee_id]'
    select medical_appointment.scheduled_at.day, from: 'medical_appointment[scheduled_at(3i)]'
    select I18n.t('date.month_names')[medical_appointment.scheduled_at.month], from: 'medical_appointment[scheduled_at(2i)]'
    select medical_appointment.scheduled_at.year, from: 'medical_appointment[scheduled_at(1i)]'
    fill_in 'medical_appointment[start_time]', with: medical_appointment.start_time
    fill_in 'medical_appointment[finish_time]', with: medical_appointment.finish_time
    fill_in 'medical_appointment[description]', with: medical_appointment.description
    find('input[type="submit"]').click

    expect(current_path).to eq medical_appointment_path(MedicalAppointment.last)
    expect(page).to have_content 'Consulta criada com sucesso!'

    expected_medical_appointment = MedicalAppointment.last
    expect(expected_medical_appointment.patient.name).to eq medical_appointment.patient.name
    expect(expected_medical_appointment.employee.name).to eq medical_appointment.employee.name
    expect(expected_medical_appointment.scheduled_at).to eq medical_appointment.scheduled_at
    expect(expected_medical_appointment.start_time).to eq medical_appointment.start_time
    expect(expected_medical_appointment.finish_time).to eq medical_appointment.finish_time
    expect(expected_medical_appointment.description).to eq medical_appointment.description
  end

  it 'I can edit a medical_appointment' do
    login_as FactoryBot.create(:user), scope: :user

    medical_appointment = FactoryBot.create :medical_appointment
    new_medical_appointment = FactoryBot.build :medical_appointment

    visit edit_medical_appointment_path(medical_appointment)
    select new_medical_appointment.patient.name, from: 'medical_appointment[patient_id]'
    select new_medical_appointment.employee.name, from: 'medical_appointment[employee_id]'
    select new_medical_appointment.scheduled_at.day, from: 'medical_appointment[scheduled_at(3i)]'
    select I18n.t('date.month_names')[new_medical_appointment.scheduled_at.month], from: 'medical_appointment[scheduled_at(2i)]'
    select new_medical_appointment.scheduled_at.year, from: 'medical_appointment[scheduled_at(1i)]'
    fill_in 'medical_appointment[start_time]', with: new_medical_appointment.start_time
    fill_in 'medical_appointment[finish_time]', with: new_medical_appointment.finish_time
    fill_in 'medical_appointment[description]', with: new_medical_appointment.description
    find('input[type="submit"]').click

    expect(current_path).to eq medical_appointment_path(medical_appointment)
    expect(page).to have_content 'Consulta atualizada com sucesso!'

    expected_medical_appointment = MedicalAppointment.find(medical_appointment.id)
    expect(expected_medical_appointment.patient.name).to eq new_medical_appointment.patient.name
    expect(expected_medical_appointment.employee.name).to eq new_medical_appointment.employee.name
    expect(expected_medical_appointment.scheduled_at).to eq new_medical_appointment.scheduled_at
    expect(expected_medical_appointment.start_time).to eq new_medical_appointment.start_time
    expect(expected_medical_appointment.finish_time).to eq new_medical_appointment.finish_time
    expect(expected_medical_appointment.description).to eq new_medical_appointment.description
  end

  it 'I can show a medical_appointment' do
    login_as FactoryBot.create(:user), scope: :user

    medical_appointment = FactoryBot.create :medical_appointment

    visit medical_appointment_path(medical_appointment)

    expect(page).to have_content medical_appointment.patient.name
    expect(page).to have_content medical_appointment.employee.name
    expect(page).to have_content medical_appointment.scheduled_at
    expect(page).to have_content medical_appointment.start_time
    expect(page).to have_content medical_appointment.finish_time
    expect(page).to have_content medical_appointment.description
  end

  it 'I can list all medical_appointments' do
    login_as FactoryBot.create(:user), scope: :user

    medical_appointments = FactoryBot.create_list :medical_appointment, 2

    visit medical_appointments_path

    medical_appointments.each do |medical_appointment|
      expect(page).to have_content medical_appointment.patient.name
      expect(page).to have_content medical_appointment.employee.name
      expect(page).to have_content medical_appointment.scheduled_at
      expect(page).to have_content medical_appointment.start_time
      expect(page).to have_content medical_appointment.finish_time
      expect(page).to have_content medical_appointment.description
    end
  end
end
