require 'spec_helper'

feature "Admin deletes a project" do
  scenario 'Visitors cannot delete projects' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
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
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Sign In"
    expect(page).to have_content("Destroy Reclaim The Throne")
  end

  scenario 'Users cannot delete projects' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
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
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Sign In"
    expect(page).to_not have_content("Destroy Reclaim The Throne")
    expect(page).to have_content("Reclaim The Throne")
  end

  scenario 'Admin deletes a project' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
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
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Sign In"
    click_on "Destroy Reclaim The Throne"
    expect(page).to have_content("We are sad to see it go!")
  end
end
