
require 'rails_helper'

feature 'snippets' do
  context 'no Snippets have been added' do
    scenario 'should display a prompt to add a Snippet' do
      visit '/snippets'
      expect(page).to have_content 'No Snippets yet'
      expect(page).to have_link 'Add a Snippet'
    end
  end

  context 'creating Snippets' do
    scenario 'prompt user to fill out a form, then displays the new Snippet' do
      visit '/snippets/new'
      fill_in('Name', :with => 'Airplane Challenge')
      fill_in('Code', :with => 'Test Code')
      click_button('Create Snippet')
      expect(page).to have_content 'Airplane Challenge'
    end
  end

  context 'showing Snippets' do
    let!(:projectName) { Snippet.create(name:'project name', code:'Hello World!')}

    scenario 'lets user view a Snippet' do
      visit '/snippets'
      click_link 'project name'
      expect(page).to have_content 'project name'
      expect(page).to have_content 'Hello World!'
      expect(current_path).to eq "/snippets/#{projectName.id}"
    end
  end

  context 'editing Snippets' do
    let!(:projectName) { Snippet.create(name:'project name', code:'Hello World!')}

    scenario 'lets user edit a Snippet' do
      visit "/snippets/#{projectName.id}"
      click_link 'Edit'
      fill_in('Name', :with => 'Edited Airplane Challenge')
      fill_in('Code', :with => 'Edited Test Code')
      click_button('Update Snippet')
      expect(page).to have_content 'Edited Airplane Challenge'
      expect(page).to have_content 'Edited Test Code'
      expect(current_path).to eq "/snippets/#{projectName.id}"
    end
  end

  context 'deletes Snippets' do
    let!(:projectName) { Snippet.create(name:'project name', code:'Hello World!')}

    scenario 'removes a Snippet when a user clicks delete button' do
      visit "/snippets/#{projectName.id}"
      click_link 'Delete'
      expect(current_path).to eq '/snippets'
      expect(page).not_to have_content 'project name'
    end
  end
end
