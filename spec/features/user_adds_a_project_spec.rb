require 'spec_helper'

feature "User adds a project" do
  
  scenario 'specifying valid information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "start a project!"
    fill_in "Title", with: "Project Title"
    fill_in "Description", with: "Some words that describe"
    fill_in "Completion Status", with: "10"
    fill_in "Success Status", with: "Needs work"
    click_button "Create Project"
    expect(page).to have_content("Project successfully added!")
  end

  scenario 'with invalid information'

end