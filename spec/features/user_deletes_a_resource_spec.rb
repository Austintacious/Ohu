require 'spec_helper'

feature "User deletes a resource" do
    
  scenario 'user deletes a resource' do
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
    attach_file('Resource 1', "#{Rails.root}/app/assets/images/Bubba.jpg")
    click_button "Create Project"
    expect(page).to have_content("Project successfully added!")
    expect(page).to have_content("Bubba")
    check "Delete Resource 1"
    click_button "Update Project"
    expect(page).to_not have_content("Bubba")
  end

  scenario 'user cannot delete resources that do not exist' do
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
    expect(page).to_not have_content("Delete Resource")
  end

  scenario 'admin can delete any resource' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "start a project!"
    fill_in "Title", with: "Reclaim The Throne"
    fill_in "Description", with: "I mean... I am the true queen of Westeros"
    fill_in "Completion Status", with: "20"
    fill_in "Tag List", with: "True Queen, Breaker of Chains, Mother of Dragons"
    attach_file('Resource 1', "#{Rails.root}/app/assets/images/Bubba.jpg")
    click_button "Create Project"
    expect(page).to have_content("Project successfully added!")
    click_link "Sign Out"
    click_link "Sign In"
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign In"
    click_link "Reclaim The Throne"
    check "Delete Resource 1"
    click_button "Update Project"
    expect(page).to_not have_content("Update Project")
  end

end