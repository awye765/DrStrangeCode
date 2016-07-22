require 'rails_helper'

feature 'viewing snippets' do

  context 'A logged in user' do
    scenario 'can view snippets on the index page' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)

      sign_in_with @user
      visit '/'

      expect(page).to have_content('Test')
    end

    scenario 'can view a snippet' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)

      visit '/'
      click_link 'project name'

      expect(page).to have_content 'project name'
      expect(page).to have_content 'Hello World!'
      expect(current_path).to eq "/snippets/#{@snippet.id}"
    end
  end

  context 'A logged out user' do
    scenario 'can view snippets on the index page' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)

      visit '/'

      expect(page).to have_content('Test')
    end

    scenario 'can view a snippet' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)

      visit '/'
      click_link 'project name'

      expect(page).to have_content 'project name'
      expect(page).to have_content 'Hello World!'
      expect(current_path).to eq "/snippets/#{@snippet.id}"
    end
  end
end
