describe 'As a User' do
  context 'In the homepage of system' do
    it 'I can see some basic informations about My doctor' do
      login_as FactoryBot.create(:user), scope: :user

      users = FactoryBot.create_list :user, 2
      patients = FactoryBot.create_list :patient, 2
      employees = FactoryBot.create_list :employee, 3

      visit root_path

      expect(page).to have_content 'Bem-Vindo à página inicial do My Doctor!'

      expect(page).to have_content 'Pacientes'
      expect(page).to have_content patients.size

      expect(page).to have_content 'Usuários'
      expect(page).to have_content users.size

      expect(page).to have_content 'Funcionários'
      expect(page).to have_content employees.size

      expect(page).to have_content 'Consultas'
      expect(page).to have_content 0
    end
  end
end
