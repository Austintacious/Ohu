require 'spec_helper'

feature "Admin deletes a project" do
  scenario 'Visitors cannot delete projects' do
    project = FactoryGirl.create(:project)
    visit root_path
    expect(page).to have_content("#{project.title}")
    expect(page).to_not have_content("Destroy #{project.title}")
  end 

  scenario 'Users cannot delete projects' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    expect(page).to have_content("#{project.title}")
    expect(page).to_not have_content("Destroy #{project.title}")
  end

  scenario 'Admin deletes a project' do
    user = FactoryGirl.create(:admin)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    expect(page).to have_content("Destroy #{project.title}")
  end
end