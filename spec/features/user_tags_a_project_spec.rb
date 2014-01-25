require 'spec_helper'

feature "User tags a project" do

  before {
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Start a Project!"
    fill_in "Title", with: "Reclaim The Throne"
    fill_in "Description", with: "I mean... I am the true queen of Westeros"
    fill_in "Completion Status", with: "20"
  }

  scenario 'is not required to tag' do
    click_button "Create Project"
    expect(page).to have_content("Reclaim The Throne")
  end

  scenario 'tags are listed alphabetically' do
    fill_in "Tag List", with: "True Queen, Breaker of Chains, Mother of Dragons"
    click_button "Create Project"
    visit root_path
    expect(page).to have_content("/ Breaker of Chains / / Mother of Dragons / / True Queen /")
  end

end
