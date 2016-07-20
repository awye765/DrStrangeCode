require 'rails_helper'

feature 'User authentication' do

  before do
    @user = create(:user)
    @snippet = create(:snippet, name: 'Test', code: 'Test code', user_id: @user.id)
  end

  scenario "can log in from the index" do
    visit '/'
    expect(page).to_not have_content('New Post')

    sign_in_with @user

    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Sign up')
    expect(page).to have_content('Log out')
  end

  scenario 'can log out once logged in' do
    visit '/'
    sign_in_with @user
    click_link 'Log out'
    expect(page).to have_content('Signed out successfully')
  end

  scenario 'can view index posts without logging in' do
    visit '/'
    expect(page).to have_content('Test')
  end

  scenario 'cannot create a new post without logging in' do
    visit '/'
    expect(page).not_to have_content('Add a Snippet')
  end

end
