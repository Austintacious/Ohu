require 'spec_helper'

feature "User signs up", %Q{As an unauthenticated user, 
I want to be able to sign up, 
so that I can have richer access to the site} do

#   * You're given an opportunity to sign up
#   * The sign-up makes you select between signing up as an individual or an organization
#   * The sign-up prompts you for a valid email
#   * You're prompted for a password
#   * You must confirm the password
#     * If the password and confirmed password are different, you're given an error message and prompted to re-enter until they match
# * Once submitted, you're shown a welcome page, and directed to your new profile

  scenario "specifying valid/required information" do
    visit root_path
    click_link "Sign Up"
    # click_button "Individual"
    fill_in "First Name", with: "Dany"
    fill_in "Last Name", with: "Targaryen"
    fill_in "Age", with: "21"
    select "MA", from: "State"
    fill_in "Email", with: "queen@westeros.com"
    fill_in "user_password", with: "motherofdragons"
    fill_in "Password Confirmation", with: "motherofdragons"
    click_button "Sign Up"
    expect(page).to have_content("You're in!")
    expect(page).to have_content("Sign Out")
  end


  scenario "required info not specified" do 
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"
    expect(page).to have_content("can't be blank")
  end

  scenario "passwords don't match" do
    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Dany"
    fill_in "Last Name", with: "Targaryen"
    fill_in "Age", with: "21"
    select "MA", from: "State"
    fill_in "Email", with: "queen@westeros.com"
    fill_in "user_password", with: "motherofdragons"
    fill_in "Password Confirmation", with: "mothaofdragoons"
    click_button "Sign Up"
    expect(page).to have_content("doesn't match Password")
  end 

end