feature 'My properties' do
  scenario 'It shows my properties when I am logged in'  do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)
    Property.create(name: 'Cottage 2', description: 'A lovelier place', ppn: 20, letter_id: letter.id)
    Property.create(name: 'Cottage 3', description: 'The loveliest place', ppn: 25, letter_id: letter.id)

    visit('/')
    click_button 'login'
    fill_in :username, with: 'username'
    fill_in :password, with: 'password'
    click_button('submit')
    click_button('My Properties')

    expect(page).to have_content('Your properties:')
    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('Cottage 2')
    expect(page).to have_content('Cottage 3')
  end
end
