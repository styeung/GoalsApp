require "spec_helper"

feature "Comment Specs" do
  before :each do
    sign_up("Sai To")
  end

  feature "Login Requirements" do

    it "requires you to be signed in to comment" do
      sign_out
      visit users_url
      click_link("Sai To")
      expect(page).to_not have_content 'Add Comment'
    end

  end

  feature "Commenting" do

    it "allows you to comment on the user" do
      sign_out
      sign_up("Andrew")
      visit users_url
      click_link("Sai To")
      fill_in "user_comment", with: 'Hello Sai To'
      click_button("Add User Comment")
      expect(page).to have_content "Hello Sai To"
    end

    it "allows you to comment on a goal" do
      make_goal("1")
      sign_out
      sign_up("Andrew")
      visit users_url
      click_link("Sai To")
      #save_and_open_page
      fill_in "comment_1", with: "You got it!"
      click_button("1")
      expect(page).to have_content "You got it!"
    end

    it "allows you to comment when there are multiple goals" do
      make_goal("1")
      make_goal("2")
      sign_out
      sign_up("Andrew")
      visit users_url
      click_link("Sai To")
      #save_and_open_page
      fill_in "comment_2", with: "You got it!"
      click_button("2")
      expect(page).to have_content "You got it!"
    end

  end

  feature "misc functionality" do

    it "allows you to remove a comment" do
      make_goal("Study")
      sign_out
      sign_up("Andrew")
      visit users_url
      click_link("Sai To")
      click_button("Study")

    end
  end

end