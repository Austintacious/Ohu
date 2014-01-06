require 'spec_helper'

feature "User votes on a project" do

  scenario 'unauthenticated users cannot vote' do
    visit root_path
    expect(page).to_not have_content("Upvote")
    expect(page).to_not have_content("Downvote")
  end
  
  scenario 'user upvotes a project' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    expect(page).to have_content("Upvote")
    expect(page).to have_content("Downvote")
    click_link "Upvote"
    expect(page).to have_content("Score: 1")
  end

  scenario 'user downvotes a project' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    expect(page).to have_content("Upvote")
    expect(page).to have_content("Downvote")
    click_link "Downvote"
    expect(page).to have_content("Score: -1")
  end

  scenario 'user can only upvote once' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    expect(page).to have_content("Upvote")
    expect(page).to have_content("Downvote")
    click_link "Upvote"
    click_link "Upvote"
    expect(page).to_not have_content("Score: 2")
  end

  scenario 'user can only downvote once' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    expect(page).to have_content("Upvote")
    expect(page).to have_content("Downvote")
    click_link "Downvote"
    click_link "Downvote"
    expect(page).to have_content("Score: -1")
  end

  scenario 'user can change their vote' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    expect(page).to have_content("Upvote")
    expect(page).to have_content("Downvote")
    click_link "Upvote"
    expect(page).to have_content("Score: 1")
    click_link "Downvote"
    expect(page).to have_content("Score: -1")
  end

end