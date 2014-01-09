feature "User tags a project" do
  
  scenario 'is not required to tag' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Add Tag(s)"
    click_button "Update Project"
    expect(page).to have_content("Here are a few current projects!")
  end

  scenario 'tags are listed alphabetically' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "#{project.title}"
    click_link "Add Tag(s)"
    fill_in "Tag List", with: "z, y, x, c, b, a"
    click_button "Update Project"
    expect(page).to have_content("Tags: a b c x y z")
  end

end