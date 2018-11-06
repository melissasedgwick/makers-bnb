feature "User registration" do
  scenario "creating a new user account" do
    visit('/')
    click_button('register')
    fill_in :name, with: "Lucas"
    fill_in :username, with: "sacullezzar"
    fill_in :email, with: "lucas.razzell@gmail.com"
    fill_in :password, with: "pass123"
    click_button('submit')
    expect(page).to have_content "Welcome to MakersBnB, Lucas!"
  end
end
