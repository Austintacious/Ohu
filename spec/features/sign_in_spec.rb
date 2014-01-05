require 'spec_helper'

feature "User signs in", %Q{As an unauthenticated user
I want to be able to sign in to my account
so that I can access profile information} do
  
  scenario 'existing user specifies valid information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'nonexistent email and password are supplied' do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: "nobody@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'existing email with wrong password is denied' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "incorrectpassword"
    click_button "Sign In"
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'already authenticated user cannot sign in again' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
  end

end