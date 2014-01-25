require 'spec_helper'

feature "User creates a project" do

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

  scenario 'with valid information' do
    visit root_path
    expect(page).to have_content("Reclaim The Throne")
  end

  scenario 'without valid information' do
    click_on "Sign Out"
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign In"
    click_on "Start a Project!"
    fill_in "Tag List", with: "True Queen, Breaker of Chains, Mother of Dragons"
    click_button "Create Project"
    expect(page).to have_content("There was a problem saving your project")
  end

  scenario 'user cannot edit project unless they created it' do
    click_on "Sign Out"
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Sign In"
    expect(page).to have_content("Reclaim The Throne")
    expect(page).to_not have_content("Edit")
  end

  scenario 'admin can edit any project' do
    click_on "Sign Out"
    admin = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Sign In"
    expect(page).to have_content("Reclaim The Throne")
    expect(page).to have_content("Edit")
  end

  scenario 'it sends a confirmation' do
    click_on "Sign Out"
    ActionMailer::Base.deliveries = []
    prev_count = Project.count
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Sign In"
    click_on "Start a Project!"
    fill_in "Title", with: "Tame Those Dragons"
    fill_in "Description", with: "This is getting out of hand."
    fill_in "Completion Status", with: "10"
    click_on "Create Project"
    expect(page).to have_content("Project successfully added!")
    expect(Project.count).to eql(prev_count + 1)
    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject("Tame Those Dragons has been created!")
    expect(last_email).to deliver_to("#{user2.email}")
  end

end
