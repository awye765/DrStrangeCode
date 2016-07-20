require 'rails_helper'

feature 'creating snippets' do
  context 'A logged in user' do
    scenario 'can create a new Snippet' do
      @user = create(:user)
      sign_in_with @user

      visit '/'

      expect(page).to have_content('Add a Snippet')
    end
  end

  context 'A logged out user' do
    scenario 'cannot create a new Snippet' do
      @user = create(:user)

      visit '/'

      expect(page).not_to have_content('Add a Snippet')
    end
  end
end
