require 'rails_helper'

feature 'creating snippets' do
  context 'A logged in user' do
    scenario 'can see the link to create a new snippet' do
      @user = create(:user)
      sign_in_with @user

      visit '/'

      expect(page).to have_content('Add a snippet')
    end

    scenario 'can add a new snippet' do
      @user = create(:user)
      sign_in_with @user

      visit '/snippets/new'
      fill_in('Name', :with => 'Airplane Challenge')
      fill_in('Code', :with => 'Test Code')
      click_button('Create snippet')

      expect(page).to have_content 'Airplane Challenge'
    end
  end

  context 'A logged out user' do
    scenario 'cannot see the link to create a new snippet' do
      visit '/'

      expect(page).not_to have_content('Add a snippet')
    end

    scenario 'cannot add a new snippet' do
      visit '/snippets/new'

      expect(current_path).to eq '/snippets'
      expect(page).to have_content 'You need to be Signed in to Add a Snippet!'
    end
  end
end
