require 'spec_helper'

feature "User joins a project" do

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
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Sign In"
    click_on "Reclaim The Throne"
  }

  scenario 'user successfully joins' do
    click_on "+"
    expect(page).to have_content("Welcome aboard!")
  end

  scenario 'user cannot be added twice' do
    click_on "+"
    expect(page).to_not have_content("+")
    expect(page).to have_content("-")
  end

  scenario 'user leaves a project' do
    click_on "+"
    click_on "-"
    expect(page).to have_content("You've been successfully removed from the group. We're sorry to see you go!")
  end

  scenario 'only project members can comment' do
    expect(page).to_not have_content("Add comment")
  end

end
