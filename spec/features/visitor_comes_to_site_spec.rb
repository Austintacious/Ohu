require 'spec_helper'

feature "Visitors can only visit the index page" do
  
  scenario 'visitor visits the home page' do
    project = FactoryGirl.create(:project)
    visit root_path
    expect(page).to have_content("#{project.title}")
    expect(page).to have_content("#{project.description}")
    expect(page).to have_content("#{project.success_status}")
    expect(page).to have_content("#{project.completion_status}")
  end

  scenario 'visitor attempts to see project page' do
    project = FactoryGirl.create(:project)
    visit root_path
    click_link "#{project.title}"
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end

end