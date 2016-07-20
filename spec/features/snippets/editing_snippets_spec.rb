require 'rails_helper'

feature 'Editing snippets' do

  context 'A logged in user' do
    scenario 'can edit a Snippet' do
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
  end

  context 'A logged out user' do
    scenario 'cannot view the edit button' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)

      visit "/snippets/#{@snippet.id}"

      expect(page).not_to have_content 'Edit'
    end

    scenario 'cannot visit the edit page through the url' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)
      visit "/snippets/#{@snippet.id}/edit"
      expect(current_path).to eq '/snippets'
      expect(page).to have_content 'You need to be Signed in to Edit a Snippet!'
    end
  end

  context 'An owner of a snippet' do
    before do
      user_one = create(:user)
      user_two = create(:user, email: 'hi@hi.com',
                               user_name: 'BennyBoy',
                               id: user_one.id + 1)

      @snippet_one = create(:snippet, user_id: user_one.id)
      @snippet_two = create(:snippet, user_id: user_one.id + 1)

      sign_in_with user_one
    end

    scenario 'can edit their own snippet' do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_one.id}')]").click
      expect(page).to have_content('Edit')

      click_link 'Edit'
      fill_in 'Name', with: "Airplane Challenge"
      fill_in 'Code', with: "```<h1>Hello World</h1>```"
      click_button 'Update Snippet'

      expect(page).to have_content("Snippet was successfully updated")
      expect(page).to have_content("<h1>Hello World</h1>")
    end

    scenario "cannot edit someone elses snippet" do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_two.id}')]").click
      expect(page).to_not have_content('Edit')
    end

    scenario "cannot edit someone elses snippet via url path" do
      visit "/snippets/#{@snippet_two.id}/edit"
      expect(page.current_path).to eq root_path
      expect(page).to have_content("That Snippet does not belong to you!")
    end
  end
end
