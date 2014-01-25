require 'spec_helper'

feature "User votes on a project", js: true do

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

  scenario 'user upvotes a project' do
    expect(page).to have_content("Score: 0")
    first(:button, "▲").click
    expect(page).to have_content("Score: 1")
  end

  scenario 'user downvotes a project' do
    expect(page).to have_content("Score: 0")
    first(:button, "▼").click
    expect(page).to have_content("Score: -1")
  end

  scenario 'unauthenticated users cannot vote' do
    click_on "Sign Out"
    visit root_path
    expect(page).to have_content("▲")
    expect(page).to have_content("▼")
    expect(page).to have_content("Score: 0")
    first(:button, "▲").click
    expect(page).to have_content("Score: 0")
  end


  scenario 'user can only upvote once' do
    expect(page).to have_content("Score: 0")
    first(:button, "▲").click
    expect(page).to have_content("Score: 1")
    first(:button, "▲").click
    expect(page).to have_content("Score: 1")
  end

  scenario 'user can only downvote once' do
    expect(page).to have_content("Score: 0")
    first(:button, "▼").click
    expect(page).to have_content("Score: -1")
    first(:button, "▼").click
    expect(page).to_not have_content("Score: -2")
  end

  scenario 'user can change their vote' do
    expect(page).to have_content("Score: 0")
    first(:button, "▲").click
    expect(page).to have_content("Score: 1")
    first(:button, "▼").click
    expect(page).to have_content("Score: -1")
  end

end
