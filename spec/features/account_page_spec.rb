feature 'Account page' do
  it "shows the user's properties" do
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    property = Property.create(name: "House", description: "Sweet pad!", ppn: 10, letter_id: user.id)
    visit ('/')
    click_button 'login'
    fill_in :username, with: 'sacullezzar'
    fill_in :password, with: 'pass123'
    click_button 'submit'
    click_button 'account_page'
    expect(page).to have_content "Hi Lucas, here is your account!"
    expect(page).to have_content "Your Properties"
    expect(page).to have_content "House"
    expect(page).to have_content "£10 per night"
    expect(page).to have_button "Update"
  end
end
