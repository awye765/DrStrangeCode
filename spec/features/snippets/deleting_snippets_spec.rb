require 'rails_helper'

feature 'Deleting snippets' do

  context 'A logged in user' do
    scenario 'can view delete button' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)


      visit "/snippets/#{@snippet.id}"

      expect(page).to have_content 'Delete'
    end

    scenario 'can delete a snippet' do
      @user = create(:user)
      sign_in_with @user
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)


      visit "/snippets/#{@snippet.id}"
      click_link 'Delete'

      expect(current_path).to eq '/snippets'
      expect(page).not_to have_content 'project name'
    end
  end

  context 'A a logged out user' do
    scenario 'cannot view delete button' do
      @user = create(:user)
      @snippet = create(:snippet, name: 'project name', code: 'Hello World!', user_id: @user.id)


      visit "/snippets/#{@snippet.id}"

      expect(page).not_to have_content 'Delete'
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

    scenario 'can delete a snippet that belongs to them' do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_one.id}')]").click
      expect(page).to have_content('Delete')

      click_link 'Delete'

      expect(page).to have_content("Snippet was successfully destroyed.")
    end

    scenario "delete a snippet that does not belong to them" do
      find(:xpath, "//a[contains(@href,'snippets/#{@snippet_two.id}')]").click
      expect(page).to_not have_content('Delete')
    end
  end
end
