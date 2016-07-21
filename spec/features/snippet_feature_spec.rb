
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

  context 'lets user add subject tags to their snippet' do

    scenario 'user can add multiple tags when creating a new snippet & see them displayed' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'Airplane Challenge', code: '    Test Code', user_id: @user.id, tag_list: 'rails, ruby, airport')
      visit '/snippets'
      expect(page).to have_content 'airport, ruby, rails'
    end

    scenario 'all added tags should be displayed on the main page' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'Airplane Challenge', code: '    Test Code', user_id: @user.id, tag_list: 'rails, ruby, airport')
      
      visit '/snippets'
      expect(page).to have_content('airport', count: 2)
      expect(page).to_not have_content('airport', count: 5)
    end

    scenario 'edited existing tag should display on the main page' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id, tag_list: 'tama, kitty')
      visit "/snippets/#{@snippet.id}"
      click_link 'Edit'
      fill_in('Tags', :with => 'tama, kat')
      click_button('Update Snippet')
      visit '/snippets'
      expect(page).to have_content('kat', count: 2)
      expect(page).to_not have_content('kat', count: 3)
    end
  end
end
