require 'rails_helper'

feature 'Editing posts' do

    before do
      user_one = create(:user)
      user_two = create(:user, email: 'hi@hi.com',
                               user_name: 'BennyBoy',
                               id: user_one.id + 1)

      @snippet_one = create(:snippet, user_id: user_one.id)
      @snippet_two = create(:snippet, user_id: user_one.id + 1)

      sign_in_with user_one
    end

    scenario 'As the owner can edit a snippet as the owner' do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_one.id}')]").click
      expect(page).to have_content('Edit')

      click_link 'Edit'
      fill_in 'Name', with: "Airplane Challenge"
      fill_in 'Code', with: "```<h1>Hello World</h1>```"
      click_button 'Update Snippet'

      expect(page).to have_content("Snippet was successfully updated")
      expect(page).to have_content("<h1>Hello World</h1>")
    end

    scenario "A stranger  cannot edit a snippet" do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_two.id}')]").click
      expect(page).to_not have_content('Edit')
    end

    scenario "A stranger cannot edit a snippet that via url path" do
      visit "/snippets/#{@snippet_two.id}/edit"
      expect(page.current_path).to eq root_path
      expect(page).to have_content("That post doesn't belong to you!")
    end

    scenario "It won't update a post without an attached image" do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_one.id}')]").click
      click_link 'Edit Snippet'
      click_button 'Update Snippet'

      expect(page).to have_content("Something is wrong with your form!")
    end
end
