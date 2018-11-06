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


feature "user log in and out" do
  before(:each) do
    User.register(name: 'Test', username: 'tester', email: 'test@test.com', password: 'testpass')
  end

  scenario "incorrect login shows an alert" do
    visit('/')
    click_button('login')
    fill_in :username, with: 'testes'
    fill_in :password, with: 'password'
    click_button('submit')
    expect(page).to have_content "Incorrect login details!"
  end
  
  scenario "a user can log in" do
    visit('/')
    click_button('login')
    fill_in :username, with: 'tester'
    fill_in :password, with: 'testpass'
    click_button('submit')
    expect(page).to have_content "Welcome to MakersBnB, Test!"
  end
end
