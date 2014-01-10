feature "User tags a project" do
  
  scenario 'is not required to tag' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "start a project!"
    fill_in "Title", with: "Reclaim The Throne"
    fill_in "Description", with: "I mean... I am the true queen of Westeros"
    fill_in "Completion Status", with: "20"
    click_button "Create Project"
    expect(page).to have_content("Reclaim The Throne (20%)")
  end

  scenario 'tags are listed alphabetically' do
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
    click_link "Home"
    expect(page).to have_content("Tags: Breaker of Chains Mother of Dragons True Queen")
  end

end