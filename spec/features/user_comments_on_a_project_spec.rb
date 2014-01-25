require 'spec_helper'

feature "User comments on a project" do

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
  }

  scenario 'with valid input' do
    fill_in "Body", with: "What a lovely project!"
    click_on "Create Comment"
    expect(page).to have_content("Total Comments: 1")
  end

  scenario 'without valid input' do
    click_on "Create Comment"
    expect(page).to have_content("There was an issue adding your comment.")
  end

  scenario 'unauthenticated user cannot comment' do
    click_on "Sign Out"
    visit root_path
    click_on "Reclaim The Throne"
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Forgot your password?")
    expect(page).to_not have_content("I mean... I am the true queen of Westeros")
  end

  scenario 'users not a part of the group cannot comment' do
    user2 = FactoryGirl.create(:user)
    click_on "Sign Out"
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Sign In"
    click_on "Reclaim The Throne"
    expect(page).to_not have_content("Body")
    expect(page).to have_content("Total Comments")
  end

  scenario 'users not a part of the group can see the total number of comments' do
    user2 = FactoryGirl.create(:user)
    click_on "Sign Out"
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Sign In"
    click_on "Reclaim The Throne"
    expect(page).to have_content("Total Comments")
  end
end
