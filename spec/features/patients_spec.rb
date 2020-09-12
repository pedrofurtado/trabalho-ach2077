describe 'As a User' do
  it 'I can create a new patient' do
    login_as FactoryBot.create(:user), scope: :user

    patient = FactoryBot.build :patient

    visit new_patient_path

    fill_in 'patient[name]', with: patient.name
    fill_in 'patient[sex]', with: patient.sex
    select patient.birthday.day, from: 'patient[birthday(3i)]'
    select I18n.t('date.month_names')[patient.birthday.month], from: 'patient[birthday(2i)]'
    select patient.birthday.year, from: 'patient[birthday(1i)]'
    fill_in 'patient[email]', with: patient.email
    fill_in 'patient[phone]', with: patient.phone
    fill_in 'patient[description]', with: patient.description
    find('input[type="submit"]').click

    expect(current_path).to eq patient_path(Patient.last)
    expect(page).to have_content 'Paciente criado com sucesso!'

    expected_patient = Patient.last
    expect(expected_patient.name).to eq patient.name
    expect(expected_patient.sex).to eq patient.sex
    expect(expected_patient.birthday).to eq patient.birthday
    expect(expected_patient.email).to eq patient.email
    expect(expected_patient.phone).to eq patient.phone
    expect(expected_patient.description).to eq patient.description
  end

  it 'I can edit a patient' do
    login_as FactoryBot.create(:user), scope: :user

    patient = FactoryBot.create :patient
    new_patient = FactoryBot.build :patient

    visit edit_patient_path(patient)
    fill_in 'patient[name]', with: new_patient.name
    fill_in 'patient[sex]', with: new_patient.sex
    select new_patient.birthday.day, from: 'patient[birthday(3i)]'
    select I18n.t('date.month_names')[new_patient.birthday.month], from: 'patient[birthday(2i)]'
    select new_patient.birthday.year, from: 'patient[birthday(1i)]'
    fill_in 'patient[email]', with: new_patient.email
    fill_in 'patient[phone]', with: new_patient.phone
    fill_in 'patient[description]', with: new_patient.description
    find('input[type="submit"]').click

    expect(current_path).to eq patient_path(patient)
    expect(page).to have_content 'Paciente atualizado com sucesso!'

    expected_patient = Patient.find(patient.id)
    expect(expected_patient.name).to eq new_patient.name
    expect(expected_patient.sex).to eq new_patient.sex
    expect(expected_patient.birthday).to eq new_patient.birthday
    expect(expected_patient.email).to eq new_patient.email
    expect(expected_patient.phone).to eq new_patient.phone
    expect(expected_patient.description).to eq new_patient.description
  end

  it 'I can show a patient' do
    login_as FactoryBot.create(:user), scope: :user

    patient = FactoryBot.create :patient

    visit patient_path(patient)

    expect(page).to have_content patient.name
    expect(page).to have_content patient.sex
    expect(page).to have_content patient.birthday
    expect(page).to have_content patient.email
    expect(page).to have_content patient.phone
    expect(page).to have_content patient.description
  end

  it 'I can list all patients' do
    login_as FactoryBot.create(:user), scope: :user

    patients = FactoryBot.create_list :patient, 2

    visit patients_path

    patients.each do |patient|
      expect(page).to have_content patient.name
      expect(page).to have_content patient.sex
      expect(page).to have_content patient.birthday
      expect(page).to have_content patient.email
      expect(page).to have_content patient.phone
      expect(page).to have_content patient.description
    end
  end
end
