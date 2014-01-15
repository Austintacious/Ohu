require 'spec_helper'

feature "User comments on a project" do

  scenario 'with valid input' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Join this project!"
    fill_in "Body", with: "This is a comment!"
    click_button "Create Comment"
    expect(page).to have_content("Comment created successfully")
  end

  scenario 'without valid input' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Join this project!"
    click_button "Create Comment"
    expect(page).to have_content("There was an issue adding your comment")
  end

  scenario 'unauthenticated user cannot comment' do
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "#{project.title}"
    expect(page).to_not have_content("Create Comment")
    expect(page).to_not have_content("Add your comment")
  end

end