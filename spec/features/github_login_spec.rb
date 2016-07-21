require 'rails_helper'

feature 'Github user authentication' do

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    successful_github_login_setup
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  context 'A user with a github account' do

    scenario "can log in " do
      github_login

      expect(page).to_not have_content('Sign up')
      expect(page).to have_content('Log out')
    end

    scenario 'can log out once logged in' do
      github_login

      click_link 'Log out'

      expect(page).to have_content('Signed out successfully')
    end

    scenario 'can view index posts without logging in' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)

      github_login

      expect(page).to have_content('Test')
    end

    scenario 'cannot create a new post without logging in' do
      @user = create(:user)

      visit '/'

      expect(page).not_to have_content('Add a Snippet')
    end

  end

end
