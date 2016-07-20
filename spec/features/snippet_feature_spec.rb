
require 'rails_helper'


feature 'Snippets' do

  context 'no Snippets have been added' do
    scenario 'should display a prompt to add a Snippet' do
      @user = create(:user)
      sign_in_with @user

      visit '/snippets'

      expect(page).to have_content 'No Snippets yet'
      expect(page).to have_link 'Add a Snippet'
    end

    scenario 'should prompt user to fill out a form, then displays the new Snippet' do
      @user = create(:user)
      sign_in_with @user

      visit '/snippets/new'
      fill_in('Name', :with => 'Airplane Challenge')
      fill_in('Code', :with => 'Test Code')
      click_button('Create Snippet')

      expect(page).to have_content 'Airplane Challenge'
    end
  end


  context 'A Snippet has been added' do
    scenario 'lets user view a Snippet' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)

      visit '/snippets'
      click_link 'project name'

      expect(page).to have_content 'project name'
      expect(page).to have_content 'Hello World!'
      expect(current_path).to eq "/snippets/#{@snippet.id}"
    end

    scenario 'lets user edit a Snippet' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)


      visit "/snippets/#{@snippet.id}"
      click_link 'Edit'
      fill_in('Name', :with => 'Edited Airplane Challenge')
      fill_in('Code', :with => 'Edited Test Code')
      click_button('Update Snippet')

      expect(page).to have_content 'Edited Airplane Challenge'
      expect(page).to have_content 'Edited Test Code'
      expect(current_path).to eq "/snippets/#{@snippet.id}"
    end

    scenario 'lets user delete a Snippet' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)


      visit "/snippets/#{@snippet.id}"
      click_link 'Delete'

      expect(current_path).to eq '/snippets'
      expect(page).not_to have_content 'project name'
    end
  end
end
