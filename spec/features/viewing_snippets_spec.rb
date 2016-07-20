require 'rails_helper'

feature 'viewing snippets' do
  context 'A logged in user' do
    scenario 'can view index posts' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)

      sign_in_with @user
      visit '/'

      expect(page).to have_content('Test')
    end
  end

  context 'A logged out user' do
    scenario 'can view index posts' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)

      visit '/'

      expect(page).to have_content('Test')
    end
  end
end
