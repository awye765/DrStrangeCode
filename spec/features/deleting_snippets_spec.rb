require 'rails_helper'

feature 'Deleting posts' do

    before do
      user_one = create(:user)
      user_two = create(:user, email: 'hi@hi.com',
                               user_name: 'BennyBoy',
                               id: user_one.id + 1)

      @snippet_one = create(:snippet, user_id: user_one.id)
      @snippet_two = create(:snippet, user_id: user_one.id + 1)

      sign_in_with user_one
    end

    scenario 'An owner can delete a snippet as the owner' do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_one.id}')]").click
      expect(page).to have_content('Delete')

      click_link 'Delete'

      expect(page).to have_content("Snippet was successfully destroyed.")
    end

    scenario "A stranger cannot delete a snippet" do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_two.id}')]").click
      expect(page).to_not have_content('Delete')
    end
end
