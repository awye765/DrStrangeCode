require 'rails_helper'
require 'spec_helper'

feature 'reviews' do
	before do
    @user = create(:user)
    sign_in_with @user
    @snippet = create(:snippet, user: @user)
    @review = create(:review, snippet: @snippet)
 end

  context 'Adding Reviews' do

    scenario 'No Reviews have been added yet' do
      
    	#review = FactoryGirl.create(:review, snippet: snippet)
			#visit '/users/sign_up'
			#sign_in_with @user
			#click_link "Add a Snippet"
			#visit new_snippet_path(@user)
      visit "/snippets/#{@snippet.id}"

      #expect(page).to have_content('No Reviews yet')
      expect(page).to have_link 'Add Code Review'
    end

    scenario 'Allows users to add a Review' do
      
      visit "/snippets/#{@snippet.id}"
      click_link 'Add Code Review'
      # save_and_open_page
      
      fill_in "Review", with: "Great Code Dude!"
      click_button 'Leave Review'


      @review = create(:review, snippet: @snippet)
      visit "/snippets/#{@snippet.id}"
      click_link 'Add Code Review'
      fill_in "Review", with: "Super Duper Code!"
      click_button 'Leave Review'
      expect(current_path).to eq("/snippets/#{@snippet.id}")
      #save_and_open_page
      expect(page).to have_content("Super Duper Code!")
      expect(page).to have_content("Great Code Dude!")
    end

  end
  
end


