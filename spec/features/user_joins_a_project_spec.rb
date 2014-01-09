require 'spec_helper'

feature "User joins a project" do
  
  scenario 'user cannot be added twice' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Join this project!"
    expect(page).to have_content("Welcome aboard!")
    expect(page).to_not have_content("Join this project!")
    expect(page).to have_content("Leave this project")
  end


  scenario 'user successfully joins' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Join this project!"
    expect(page).to have_content("#{user.first_name}")
    expect(page).to have_content("#{user.last_name}")
  end

  scenario 'user leaves a project' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Join this project!"
    expect(page).to have_content("Welcome aboard!")
    expect(page).to_not have_content("Join this project!")
    expect(page).to have_content("Leave this project")
    click_link "Leave this project"
    expect(page).to have_content("You've been successfully removed from the group. We're sorry to see you go!")
  end

  scenario 'only project members can comment' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    expect(page).to_not have_content("Add comment")
  end

end