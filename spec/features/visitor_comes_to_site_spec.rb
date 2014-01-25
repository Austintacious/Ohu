require 'spec_helper'

feature "Visitors can only visit the index page" do

  before {
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign In"
    click_on "Start a Project!"
    fill_in "Title", with: "Reclaim The Throne"
    fill_in "Description", with: "I mean... I am the true queen of Westeros"
    fill_in "Completion Status", with: "20"
    click_on "Create Project"
    click_on "Sign Out"
  }

  scenario 'visitor visits the home page' do
    visit root_path
    expect(page).to have_content("Reclaim The Throne")
    expect(page).to have_content("20%")
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
  end

  scenario 'visitor attempts to see project page' do
    visit root_path
    click_link "Reclaim The Throne"
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Forgot your password?")
  end

end
