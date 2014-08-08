require 'spec_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signing up" do
      sign_up("Sai To")
      expect(page).to have_content "Sai To"
    end
  end
end

feature "logging in" do

  it "shows the username on the homepage after login" do
    sign_up("Sai To")
    sign_out
    sign_in("Sai To")
    expect(page).to have_content "Sai To"
  end
end

feature "logging out" do
  it "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content "Sign In"
  end

  it "doesn't show username on the homepage after logout" do
    sign_up("Sai To")
    sign_out
    expect(page).to_not have_content "Sai To"
  end

end