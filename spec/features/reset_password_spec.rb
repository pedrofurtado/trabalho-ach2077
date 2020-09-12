describe 'As a User' do
  before :each do
    @user = FactoryBot.create :user
    clear_mail_deliveries
  end

  context 'I can receive an email with reset password instructions' do
    it 'With correct email' do
      visit new_user_password_path
      fill_in_new_password_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'I can not receive an email with reset password instructions' do
    it 'With wrong email' do
      visit new_user_password_path

      @user.email = 'wrong_email@example.com'
      fill_in_new_password_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq user_password_path
      expect_not_sent_reset_password_instructions_email_for @user
    end
  end

  context 'I can reset password' do
    it 'With correct reset password token' do
      visit edit_user_password_path(reset_password_token: @user.send(:set_reset_password_token))
      fill_in_edit_password_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq root_path
    end
  end

  context 'I can not reset password' do
    it 'With wrong reset password token' do
      visit edit_user_password_path(reset_password_token: 'wrong-reset-password-token')
      fill_in_edit_password_form_for @user
      find('input[type="submit"]').click
      expect(current_path).to eq user_password_path
    end
  end

  def fill_in_new_password_form_for(user)
    fill_in 'user[email]', with: user.email
  end

  def fill_in_edit_password_form_for(_user)
    password = 'my_very_strong_password'

    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
  end

  def clear_mail_deliveries
    ActionMailer::Base.deliveries.clear
  end

  def expect_not_sent_reset_password_instructions_email_for(_user)
    email_deliveries = ActionMailer::Base.deliveries

    expect(email_deliveries.count).to eq 0
  end
end
