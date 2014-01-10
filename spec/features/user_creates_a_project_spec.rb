require 'spec_helper'

feature "User creates a project" do

  scenario 'with valid information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "start a project!"
    fill_in "Title", with: "Reclaim The Throne"
    fill_in "Description", with: "I mean... I am the true queen of Westeros"
    fill_in "Completion Status", with: "20"
    fill_in "Tag List", with: "True Queen, Breaker of Chains, Mother of Dragons"
    click_button "Create Project"
    expect(page).to have_content("Reclaim The Throne (20%)")
    expect(page).to have_content("Project successfully added!")
  end

  scenario 'without valid information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "start a project!"
    fill_in "Tag List", with: "True Queen, Breaker of Chains, Mother of Dragons"
    click_button "Create Project"
    expect(page).to have_content("can't be blank")
  end

  scenario 'user cannot edit project unless they created it' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    expect(page).to have_content("#{project.title}")
    expect(page).to_not have_content("Edit")
  end

  scenario 'admin can edit any project' do
    user = FactoryGirl.create(:admin)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    expect(page).to have_content("#{project.title}")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Destroy #{project.title}")
  end
  
end