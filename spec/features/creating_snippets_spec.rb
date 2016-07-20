require 'rails_helper'

feature 'creating snippets' do
  context 'A logged in user' do

  end

  context 'A logged out user' do
    scenario 'cannot create a new post without logging in' do
      @user = create(:user)

      visit '/'

      expect(page).not_to have_content('Add a Snippet')
    end
  end
end
