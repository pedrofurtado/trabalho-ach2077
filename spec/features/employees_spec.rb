describe 'As a User' do
  it 'I can create a new employee' do
    login_as FactoryBot.create(:user), scope: :user

    employee = FactoryBot.build :employee

    visit new_employee_path

    fill_in 'employee[name]', with: employee.name
    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[job]', with: employee.job
    fill_in 'employee[phone]', with: employee.phone
    find('input[type="submit"]').click

    expect(current_path).to eq employee_path(Employee.last)
    expect(page).to have_content 'Funcionário criado com sucesso!'

    expected_employee = Employee.last
    expect(expected_employee.name).to eq employee.name
    expect(expected_employee.email).to eq employee.email
    expect(expected_employee.job).to eq employee.job
    expect(expected_employee.phone).to eq employee.phone
  end

  it 'I can edit a employee' do
    login_as FactoryBot.create(:user), scope: :user

    employee = FactoryBot.create :employee
    new_employee = FactoryBot.build :employee

    visit edit_employee_path(employee)
    fill_in 'employee[name]', with: new_employee.name
    fill_in 'employee[email]', with: new_employee.email
    fill_in 'employee[job]', with: new_employee.job
    fill_in 'employee[phone]', with: new_employee.phone
    find('input[type="submit"]').click

    expect(current_path).to eq employee_path(employee)
    expect(page).to have_content 'Funcionário atualizado com sucesso!'

    expected_employee = Employee.find(employee.id)
    expect(expected_employee.name).to eq new_employee.name
    expect(expected_employee.email).to eq new_employee.email
    expect(expected_employee.job).to eq new_employee.job
    expect(expected_employee.phone).to eq new_employee.phone
  end

  it 'I can show a employee' do
    login_as FactoryBot.create(:user), scope: :user

    employee = FactoryBot.create :employee

    visit employee_path(employee)

    expect(page).to have_content employee.name
    expect(page).to have_content employee.email
    expect(page).to have_content employee.job
    expect(page).to have_content employee.phone
  end

  it 'I can list all employees' do
    login_as FactoryBot.create(:user), scope: :user

    employees = FactoryBot.create_list :employee, 2

    visit employees_path

    employees.each do |employee|
      expect(page).to have_content employee.name
      expect(page).to have_content employee.email
      expect(page).to have_content employee.job
      expect(page).to have_content employee.phone
    end
  end
end
