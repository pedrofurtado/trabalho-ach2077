describe 'As a User' do
  before :each do
    @user = FactoryBot.build :user
  end

  it 'I can register' do
    visit new_user_registration_path
    fill_in_form_for @user
    find('input[type="submit"]').click
    expect(current_path).to eq '/users/sign_in'
  end

  def fill_in_form_for(user)
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
  end
end
