require "spec_helper"

feature "goal creation process" do
  before :each do
    sign_up("Sai To")
  end


  it "requires user to be signed in" do
    sign_out
    visit new_goal_url
    expect(page).to have_content('Sign In')
  end

  it "requires you to be the page owner to create goals" do
    sign_out
    visit users_url
    click_link("Sai To")
    expect(page).to_not have_content("New Goal")
  end

  it "has a goal creation page" do
    visit new_goal_url
    expect(page).to have_content('Goal')
  end

  it "shows goal on user page after creation" do
    visit new_goal_url
    fill_in "Goal", with: 'eat less'
    choose('Public')
    click_button 'Create Goal'
    expect(page).to have_content('eat less')
  end

  it "does not show private goals to others" do
    visit new_goal_url
    fill_in "Goal", with: 'eat less'
    choose('Private')
    click_button 'Create Goal'
    sign_out
    visit users_url
    click_link('Sai To')
    expect(page).to_not have_content('eat less')
  end

  it "allows you to delete a goal" do
    visit new_goal_url
    fill_in "Goal", with: 'eat less'
    choose('Private')
    click_button 'Create Goal'
    click_button 'Delete Goal'
    expect(page).to_not have_content('eat less')
  end

  it "allows you to edit a goal" do
    visit new_goal_url
    fill_in "Goal", with: 'eat less'
    choose('Private')
    click_button 'Create Goal'
    click_button 'Edit Goal'
    fill_in "Goal", with: 'eat less2'
    click_button 'Update Goal'

    expect(page).to have_content('eat less2')
  end


end