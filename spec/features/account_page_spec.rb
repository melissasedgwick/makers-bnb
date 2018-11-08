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

  it 'it shows multiple user properties' do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)
    Property.create(name: 'Cottage 2', description: 'A lovelier place', ppn: 20, letter_id: letter.id)
    Property.create(name: 'Cottage 3', description: 'The loveliest place', ppn: 25, letter_id: letter.id)

    visit('/')
    click_button 'login'
    fill_in :username, with: 'username'
    fill_in :password, with: 'password'
    click_button('submit')
    click_button('account_page')

    expect(page).to have_content('Your Properties')
    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('Cottage 2')
    expect(page).to have_content('Cottage 3')
  end

  it 'it shows booking requests per property' do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    property = Property.create(name: "House", description: "Sweet pad!", ppn: 10, letter_id: user.id)
    Booking.submit_availability(date: "2018/06/06", property_id: property.id, letter_id: letter.id)
    request = Booking.request_booking(date: "2018/06/06", property_id: property.id, renter_id: user.id)

    visit ('/')
    click_button 'login'
    fill_in :username, with: 'sacullezzar'
    fill_in :password, with: 'pass123'
    click_button 'submit'
    click_button 'account_page'
    expect(page).to have_content "Bookings"
    expect(page).to have_content request.date
  end

  it 'it shows a list of confirmed bookings for the renter' do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    property = Property.create(name: "House", description: "Sweet pad!", ppn: 10, letter_id: user.id)
    Booking.submit_availability(date: "2018/06/06", property_id: property.id, letter_id: letter.id)
    request = Booking.request_booking(date: "2018/06/06", property_id: property.id, renter_id: user.id)
    Booking.confirm_booking(id: request.id)

    visit ('/')
    click_button 'login'
    fill_in :username, with: 'sacullezzar'
    fill_in :password, with: 'pass123'
    click_button 'submit'
    click_button 'account_page'

    expect(page).to have_content request.date
    expect(page).to have_content "Approved"
  end

  it 'shows a pending booking' do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    property = Property.create(name: "House", description: "Sweet pad!", ppn: 10, letter_id: user.id)
    Booking.submit_availability(date: "2018/06/06", property_id: property.id, letter_id: letter.id)
    request = Booking.request_booking(date: "2018/06/06", property_id: property.id, renter_id: user.id)

    visit ('/')
    click_button 'login'
    fill_in :username, with: 'sacullezzar'
    fill_in :password, with: 'pass123'
    click_button 'submit'
    click_button 'account_page'

    expect(page).to have_content request.date
    expect(page).to have_content "Pending"
  end

  it 'lists approved bookings for the logged in user' do
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    user2 = User.register(name: 'Aimee', username: 'ac', email: 'aimee@gmail.com', password: 'pass')
    letter = User.register(name: 'Lucy', username: 'famalam', email: 'penis@flytrap.com', password: 'peniarecool')
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)

    Booking.submit_availability(date: "2018/06/06", property_id: property.id, letter_id: letter.id)
    Booking.submit_availability(date: "2018/06/07", property_id: property.id, letter_id: letter.id)
    Booking.request_booking(date: "2018/06/07", property_id: property.id, renter_id: user2.id)
    request = Booking.request_booking(date: "2018/06/06", property_id: property.id, renter_id: user.id)
    Booking.confirm_booking(id: request.id)

    visit ('/')
    click_button 'login'

    fill_in :username, with: 'sacullezzar'
    fill_in :password, with: 'pass123'

    click_button 'submit'

    click_button 'account_page'

    expect(page).to have_content('Your Bookings')
    expect(page).to have_content('2018-06-06')
    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('15')
    expect(page).not_to have_content('2018-06-07')
  end
end
