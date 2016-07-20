require 'rails_helper'

feature 'User authentication' do

  context 'A user with an account' do
    scenario "can log in " do
      @user = create(:user)

      sign_in_with @user

      expect(page).to have_content('Signed in successfully.')
      expect(page).to_not have_content('Sign up')
      expect(page).to have_content('Log out')
    end

    scenario 'can log out once logged in' do
      @user = create(:user)

      sign_in_with @user
      click_link 'Log out'

      expect(page).to have_content('Signed out successfully')
    end

    scenario 'can view index posts without logging in' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)

      visit '/'

      expect(page).to have_content('Test')
    end

    scenario 'cannot create a new post without logging in' do
      @user = create(:user)

      visit '/'

      expect(page).not_to have_content('Add a Snippet')
    end
  end

  context 'A user without an account' do
    scenario "can not log in " do
      @user = build(:user)

      sign_in_with @user

      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
