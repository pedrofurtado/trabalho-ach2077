describe 'As a User' do
  before :each do
    @user = FactoryBot.create :user
  end

  context 'I can sign in' do
    it 'With correct email and password' do
      visit new_user_session_path
      fill_in_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq root_path
    end
  end

  context 'I can not sign in' do
    it 'With wrong password' do
      visit new_user_session_path
      @user.password = 'wrong password'
      fill_in_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq new_user_session_path
    end

    it 'With wrong email' do
      visit new_user_session_path
      @user.email = 'wrong email'
      fill_in_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq new_user_session_path
    end
  end

  def fill_in_form_for(user)
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
  end
end
